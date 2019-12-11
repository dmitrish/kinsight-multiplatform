package kinsight.server.api

import io.ktor.application.*
import io.ktor.features.*
import io.ktor.html.*
import io.ktor.http.ContentType
import io.ktor.http.Url
import io.ktor.response.header
import io.ktor.response.respondText
import io.ktor.jackson.jackson
import io.ktor.routing.*
import kotlinx.html.*
import io.ktor.client.*
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.http.cio.websocket.*
import io.ktor.http.cio.websocket.CloseReason
import io.ktor.http.cio.websocket.Frame
import io.ktor.websocket.*
import io.ktor.client.request.get
import io.ktor.client.request.url
import java.io.*
import java.text.DateFormat
import io.ktor.gson.*
import io.ktor.request.receive
import io.ktor.response.respond
import io.ktor.sessions.*
import io.ktor.util.generateNonce
import kotlinx.coroutines.channels.consumeEach
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import com.google.appengine.api.urlfetch.URLFetchServiceFactory
import io.ktor.http.cio.websocket.Serializer
import kotlinx.serialization.*
import kotlinx.serialization.Serializable
import kotlinx.serialization.internal.StringDescriptor
import java.net.URL
import java.text.SimpleDateFormat
import java.util.*
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle
import kinsight.server.api.model.*
import kinsight.server.api.service.*
import kinsight.server.api.web.*

import com.fasterxml.jackson.databind.SerializationFeature
import io.ktor.http.CacheControl
import io.ktor.http.CacheControl.NoCache
import io.ktor.http.content.CachingOptions
import io.ktor.http.content.OutgoingContent
import kotlinx.coroutines.launch
import kotlinx.coroutines.*

import java.util.Timer
import kotlin.concurrent.fixedRateTimer
import kotlin.concurrent.schedule
import kotlin.math.nextUp
import kotlin.system.measureTimeMillis

/**
 * A dedicated context for sample "compute-intensive" tasks.
 */
val compute = newFixedThreadPoolContext(4, "compute")

/**
 * An alias to simplify a suspending functional type.
 */
typealias DelayProvider = suspend (ms: Int) -> Unit

@Serializable data class Ticker (
    @SerialName("symbol")
    val symbol: String,
    @SerialName("exchange")
                   val exchange: String,
    @SerialName("name")
                   val name: String,
    @SerialName("type")
                   val type: String,
    @SerialName("region")
                   val region: String,
    @SerialName("currency")
                   val currency: String,
    @SerialName("isEnabled")
                   val isEnabled: Boolean)

@Serializable data class Idea(val id: Int,
                              @SerialName("absolutePerformance")
                              val absolutePerformance: Double,
                              @SerialName("alpha")
                              var alpha: Double,
                              @SerialName("benchMarkTicker")
                              val benchMarkTicker: String = "SPX",
                              @SerialName("benchMarkTickerDesk")
                              val benchMarkTickerDesk: String = "S&P 500 Index",
                              @SerialName("benchMarkCurrentPrice")
                              val benchMarkCurrentPrice: Double,
                              @SerialName("benchMarkPerformance")
                              val benchMarkPerformance: Double,
                              @SerialName("convictionId")
                              val convictionId: Int,
                              @SerialName("currentPrice")
                              var currentPrice: Double,
                              @SerialName("direction")
                              val direction: String,
                              @SerialName("directionId")
                              val directionId: Int,
                              @SerialName("entryPrice")
                              val entryPrice: Double,
                              @SerialName("reason")
                              val reason: String,
                              @SerialName("securityName")
                              val securityName: String,
                              @SerialName("securityTicker")
                              val securityTicker: String,
                              @SerialName("stockCurrency")
                              val stockCurrency: String,
                              @SerialName("stopLoss")
                              val stopLoss:Int,
                              @SerialName("stopLossValue")
                              val stopLossValue: Double,
                              @SerialName("targetPrice")
                              val targetPrice: Double,
                              @SerialName("targetPricePercentage")
                              val targetPricePercentage: Double,
                              @SerialName("timeHorizon")
                              val timeHorizon: String,
                              @SerialName("createdBy")
                              val createdBy: String,
                                @SerialName("createdFrom")
                                var createdFrom: String,
                                @SerialName("previousCurrentPrice")
                                var previousCurrentPrice: Double,
                              @SerialName ("isActive")
                              var isActive: Boolean
                                )

var ideas = mutableListOf<Idea>()
var wssessions=  mutableListOf<WebSocketSession>()
var tickers = mutableListOf<Ticker>()

val iexBaseUrl = "https://cloud.iexapis.com/stable"
val iexRefDataUrl = "/ref-data/symbols?token="

val iexToken = "pk_8d8f1bbd966643e0984dd17aa9fa8fbb"//"useyourown"

val widgetService = WidgetService()

data class ClientSession
    (val id: String)

private val clientOutgoing by lazy {
    HttpClient() {
        install(JsonFeature) {
            serializer = KotlinxSerializer(Json(JsonConfiguration(strictMode = false))).apply {
                setMapper(Ticker::class, Ticker.serializer())

            }
        }
    }
}

fun loadResourceText(path: String): String {
    println("trying to read embedded ideas json...")
    val jsonStreamResource = Application::class.java.getResourceAsStream(path)
    val text = BufferedReader(InputStreamReader(jsonStreamResource)).readText()
    return text
}

fun loadEmbeddedJsonIdeas(){
    try{
        val fileIdeasText = loadResourceText("/ideas3.json")
       val fileIdeas = Json.nonstrict.parse(Idea.serializer().list, fileIdeasText).toMutableList()
        ideas.clear()
        ideas.addAll(fileIdeas)
        println("reader: $fileIdeasText")
    }
    catch(e: Throwable){
        println("failed loading embedded ideas json: " + e.message)
    }
}
/**
 * Entry Point of the application. This function is referenced in the
 * resources/application.conf file inside the ktor.application.modules.
 *
 * For more information about this file: https://ktor.io/servers/configuration.html#hocon-file
 */
fun Application.main(random: Random = Random(), delayProvider: DelayProvider = { delay(it.toLong()) }) {

    loadEmbeddedJsonIdeas()

    /*
    ideas.add(Idea(11,
        absolutePerformance = 3.4212,
        alpha = 3.0912,
        benchMarkCurrentPrice = 2856.66,
        benchMarkPerformance = 0.3920,
        benchMarkTicker = "SPX",
        convictionId = 1,
        currentPrice = 24.59,
        direction = "Long",
        directionId = 1,
        entryPrice = 348.213,
        reason = "Target Price",
        securityName = "Boeing",
        securityTicker = "BA US",
        stockCurrency = "USD",
        stopLoss = 10,
        stopLossValue = 313.4823,
        targetPrice = 360.00,
        targetPricePercentage = 0.00,
        timeHorizon = "1 Week",
        createdBy = "Dmitri",
        createdFrom = "Web",
        previousCurrentPrice = 24.59,
        isActive = true

    ))
*/
/*
    try {
        val fileIdeasText = File("WEB-INF/ideas2.json").readText()
        val fileIdeas = Json.nonstrict.parse(Idea.serializer().list, fileIdeasText).toMutableList()
        ideas.addAll(fileIdeas)
    }
    catch(e: Throwable){
        println("exception loading ideas file: ${e.message} ${e.stackTrace}")
    }
*/

    install(WebSockets) {
        pingPeriod = java.time.Duration.ofMinutes(1)
    }

    install(Sessions) {
        cookie<ClientSession>("SESSION")
    }

    // This adds an interceptor that will create a specific session in each request if no session is available already.
    intercept(ApplicationCallPipeline.Features) {
        if (call.sessions.get<ClientSession>() == null) {
            call.sessions.set(ClientSession(generateNonce()))
        }
    }
    //ideas.add(Idea(12, "GOOD US", 5.30))

    // This adds automatically Date and Server headers to each response, and would allow you to configure
    // additional headers served to each response.
    install(DefaultHeaders)
    // This uses use the logger to log every call (request/response)
    install(CallLogging)
    install(ContentNegotiation) {
        gson {
            setDateFormat(DateFormat.LONG)
            setPrettyPrinting()
        }
    }


    install(CachingHeaders){
        /*CachingOptions(CacheControl.NoCache(CacheControl.Visibility.Private))*/

        CachingOptions(CacheControl.MaxAge(maxAgeSeconds = 1))

        /*options{
                /*outgoingContent: OutgoingContent -> val cachingOptions = CachingOptions(cacheControl = CacheControl.NoCache(
            CacheControl.Visibility.Private))
            cachingOptions*/

            outgoingContent -> CachingOptions(CacheControl.MaxAge(maxAgeSeconds = 1))
        }

        */
    }

    /*
    install(ContentNegotiation) {
        jackson {
            configure(SerializationFeature.INDENT_OUTPUT, true)
        }
    }

     */



    // Registers routes
    suspend fun sendSignalToClient(signal: String) {
        try {
            for (wssession in wssessions) {
                try {
                    wssession.send(Frame.Text(signal))
                } catch (e: Throwable) {
                    println("Exception in Hi: ${e.message}")
                }
            }
        } catch (e: Throwable) {
            println("Exception in outer Hi: ${e.message}")
        }
    }

    routing {
        // For the root / route, we respond with an Html.
        // The `respondHtml` extension method is available at the `ktor-html-builder` artifact.
        // It provides a DSL for building HTML to a Writer, potentially in a chunked way.
        // More information about this DSL: https://github.com/Kotlin/kotlinx.html
        get("/") {
            call.respondHtml {
                head {
                    title { +"Ktor: Alpha Capture" }
                }
                body {
                    p {
                        +"Alpha Capture Ktor Server on Google Appengine"
                    }
                }
            }
        }

        get("/api/ideas") {
            call.respond(ideas.sortedByDescending { it -> it.alpha }.toMutableList())
        }

        get("/api/reset"){
            loadEmbeddedJsonIdeas()
            call.respond(mapOf("OK" to true))
        }

        get ("/api/1"){
            val json = File("WEB-INF/ideas3.json").readText()
                call.respondText(json,  ContentType.Application.Json)
        }

        get("/api/ticker/{ticker}"){
            val filter =  call.parameters["ticker"]!!.toUpperCase(Locale.ROOT)
            val filtered = tickers.filter { it.symbol.startsWith(filter) }
            call.respond(filtered)
        }

        get("/api/stock/quote/{ticker}"){

            var ticker =call.parameters["ticker"]!!.toUpperCase(Locale.ROOT)

            val client = HttpClient()
            val address =    Url("$iexBaseUrl/stock/$ticker/quote?token=$iexToken")
            var result = ""

            try {
                result = client.get<String> {
                    url(address.toString())
                }
                println(result)
                call.respond(result)

            } catch (t: Throwable) {
                call.respondText(
                    (if (t.message != null) t.message!! else ""),
                    ContentType.Application.Json
                )
            }

        }

        get("/api/graph/{id}"){
            val id =  call.parameters["id"]!!.toUpperCase(Locale.ROOT)
            val text = loadResourceText("/${id}.json")
            call.respondText ( text, ContentType.Application.Json )
        }

        get ("/appengine/loadtickers"){
            if (tickers == null || tickers.count() == 0) {
                val urlString = "$iexBaseUrl$iexRefDataUrl$iexToken"
                val url = URL(urlString)
                val response = URLFetchServiceFactory.getURLFetchService().fetch(url)
                val text = String(response.content)
                println(text)
                tickers = Json.nonstrict.parse(Ticker.serializer().list, text).toMutableList()
            }
            call.respond(tickers)
        }

        get("/api/loadtickers"){

            if (tickers == null || tickers.count() == 0) {
                val client = HttpClient()
                val address =    Url("$iexBaseUrl$iexRefDataUrl$iexToken")
                var result = ""
                var finalResult: MutableList<Ticker>? = null

                try {
                    result = client.get<String> {
                        url(address.toString())
                    }
                    //println(result)

                    var resultJson = Json.nonstrict.parse(Ticker.serializer().list, result).toMutableList()
                    println("loaded ticker count before ${resultJson.count()}")
                    resultJson = resultJson.filter { it.type == "cs" }.toMutableList()
                    println("loaded ticker count after ${resultJson.count()}")
                    tickers =  resultJson

                } catch (t: Throwable) {
                    call.respondText(
                        (if (t.message != null) t.message!! else ""),
                        ContentType.Application.Json
                    )
                }
            }

            call.respond(tickers)

        }

        post("/api/hi"){
            sendSignalToClient("reload")
            call.respond(mapOf("OK" to true))
        }

        post("/api/postidea") {
            val post = call.receive<Idea>()
            ideas.add(post)

            sendSignalToClient("NEWIDEA|${post.createdBy} created a new ${post.direction} idea on ${post.securityTicker} with price objective of \$${post.targetPrice}|${post.createdBy}|${post.createdFrom}|${post.id}")

            call.respond(mapOf("OK" to true))
        }
        post("/api/updateidea") {
            val post = call.receive<Idea>()
            var idea = ideas.find { it.id == post.id }
            var index = ideas.indexOf(idea)
            ideas[index] = post

            sendSignalToClient("UPDATEIDEA|${post.createdBy} Updated an ${post.direction} idea on ${post.securityTicker} with price objective of \$${post.targetPrice}|${post.createdBy}|${post.createdFrom}|${post.id}")

            call.respond(mapOf("OK" to true))
        }

        post("/api/closeidea") {
            val post = call.receive<Idea>()

            ideas.mapNotNull { if(it.id == post.id) it.isActive = false }

            sendSignalToClient("CLOSEIDEA|${post.createdBy} Closed an ${post.direction} idea on ${post.securityTicker} with price objective of \$${post.targetPrice}|${post.createdBy}|${post.createdFrom}|${post.id}")

            call.respond(mapOf("OK" to true))
        }

        post("/api/deleteidea") {
            val post = call.receive<Idea>()
            var idea = ideas.find { it.id == post.id }
            var index = ideas.indexOf(idea)
            ideas.removeAt(index)
            //sendReloadSignal()
            call.respond(mapOf("OK" to true))
        }

        post("/api/simulate/{id}") {
            val id =  call.parameters["id"]!!.toInt()

            val formatter = DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM)
            val simulateStartTime = LocalDateTime.now().format(formatter)

            println("simulate start... $simulateStartTime")


            val startTime = System.currentTimeMillis()
            call.respondHandlingLongCalculation(random, delayProvider, startTime, id)

            val simulateEndTime = LocalDateTime.now().format(formatter)

            println("simulate end... $simulateEndTime")

        }

        webSocket("/ws") { // this: WebSocketSession ->
            val wssession = this

            println("ws route hit")

            incoming.consumeEach { frame ->
                // Frames can be [Text], [Binary], [Ping], [Pong], [Close].
                // We are only interested in textual messages, so we filter it.
                if (frame is Frame.Text) {

                    val text = frame.readText()
                    println("server ws received frame with text: $text")

                    if (text == "Android client connecting") {
                       println ("session hashcode: " + wssession.hashCode())
                        wssessions.add(wssession)
                        this.send(Frame.Text("server acknowledged client connection"))
                        for (wssession in wssessions) {
                            try {
                                wssession.send(Frame.Text("server received this message from client: $text"))
                            }
                            catch(e: Throwable){
                                println("Exception in ws channel: ${e.message}")
                            }
                        }

                        println("server received: " + text)

                        if (text.equals("bye", ignoreCase = true)) {
                            close(
                                CloseReason(
                                    CloseReason.Codes.NORMAL,
                                    "Client said BYE. Disconnecting..."
                                )
                            )
                        }
                    }
                }
            }
        }

            widget(widgetService)

    }

    DatabaseFactory.init()



}

// Registers routes
private suspend fun Application.sendReloadSignal(signal: String) {
    try {
        for (wssession in wssessions) {
            try {
                if(wssession.isActive) {
                    wssession.send(Frame.Text(signal))
                }
            } catch (e: Throwable) {
                println("Exception in Application.sendReloadSignal: ${e.message}")
            }
        }
    } catch (e: Throwable) {
        println("Exception in outer Application.sendReloadSignal: ${e.message}")
    }
}

/**
 * Function that will perform a long computation in a threadpool generating random numbers
 * and then will respond with the result.
 */
private suspend fun ApplicationCall.respondHandlingLongCalculation(random: Random, delayProvider: DelayProvider, startTime: Long, ideaid: Int) {
    val queueTime = System.currentTimeMillis() - startTime
    val upIndexes: IntArray = intArrayOf(0, 1, 4, 5 )
    val downIndexes: IntArray = intArrayOf(2, 3)
    val poaIndex: IntArray = intArrayOf(6)

    val computeTime = measureTimeMillis {
        // We specify a coroutine context, that will use a thread pool for long computing operations.
        // In this case it is not necessary since we are "delaying", not sleeping the thread.
        // But serves as an example of what to do if we want to perform slow non-asynchronous operations
        // that would block threads.
        withContext(compute) {
            for (index in 0 until 7) {
                println("before: index: $index alpha:  ${ideas.first{x ->x.id == ideaid}.alpha}")

                var idea = ideas.filter { it.id == ideaid }.first()

                if(upIndexes.contains(index)) {
                    idea.previousCurrentPrice = idea.currentPrice;
                    idea.currentPrice = idea.currentPrice + ((idea.currentPrice / 100) * 3.4)
                    idea.alpha = idea.alpha + ((idea.alpha / 100) * 3.4)

                    println("after: reload - alpha:  ${ideas.first{x ->x.id == ideaid}.alpha}")
                    application.sendReloadSignal("RELOAD")
                    delayProvider(2500)
                }

                if(downIndexes.contains(index)){
                    idea.previousCurrentPrice = idea.currentPrice;
                    idea.currentPrice = idea.currentPrice - ((idea.currentPrice / 100) * 1.4)
                    idea.alpha = idea.alpha - ((idea.alpha / 100) * 1.4)

                    println("after: reload - alpha:  ${ideas.first{x ->x.id == ideaid}.alpha}")
                    application.sendReloadSignal("RELOAD")
                    delayProvider(2500)
                }

                if(poaIndex.contains(index))
                {
                    idea.previousCurrentPrice = idea.currentPrice;
                    idea.currentPrice = idea.targetPrice;
                    idea.alpha = idea.alpha + ((idea.alpha / 100) * 5.4)

                    println("after: poa - alpha:  ${ideas.first{x ->x.id == ideaid}.alpha}")

                    application.sendReloadSignal("PRICEOBJECTIVE|Price Objective Achieved on Idea ${idea.securityTicker} with target price of \$${idea.targetPrice}|${idea.createdBy}|${idea.createdFrom}|${idea.id}")
                }
            }
        }
    }

    respond(mapOf("OK" to true))
}
