package kinsight.server.api

import io.ktor.application.*
import io.ktor.features.*
import io.ktor.html.*
import io.ktor.http.ContentType
import io.ktor.http.Url
import io.ktor.response.header
import io.ktor.response.respondText
import io.ktor.routing.*
import kotlinx.html.*
import io.ktor.client.*
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
import java.lang.Exception


data class Idea(val id: Int,
                val absolutePerformance: Double,
                var alpha: Double,
                val benchMarkTicker: String = "SPX",
                val benchMarkTickerDesk: String = "S&P 500 Index",
                val benchMarkCurrentPrice: Double,
                val benchMarkPerformance: Double,
                val convictionId: Int,
                val currentPrice: Double,
                val direction: String,
                val directionId: Int,
                val entryPrice: Double,
                val reason: String,
                val securityName: String,
                val securityTicker: String,
                val stockCurrency: String,
                val stopLoss:Int,
                val stopLossValue: Double,
                val targetPrice: Double,
                val targetPricePercentage: Double,
                val timeHorizon: String,
                val createdBy: String)

var ideas = mutableListOf<Idea>()
var wssessions=  mutableListOf<WebSocketSession>()


data class ClientSession
    (val id: String)
/**
 * Entry Point of the application. This function is referenced in the
 * resources/application.conf file inside the ktor.application.modules.
 *
 * For more information about this file: https://ktor.io/servers/configuration.html#hocon-file
 */
fun Application.main() {

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
        createdBy = "Dmitri"))


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

    // Registers routes
    suspend fun sendReloadSignal() {
        try {
            for (wssession in wssessions) {
                try {
                    wssession.send(Frame.Text("reload"))
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
            call.respond(ideas)
        }

        get ("/api/1"){
            val html = File("files/index.html").readText()

                call.respondText(html, ContentType.Text.Html)

        }
        get("/api/remotedata"){
            val client = HttpClient()
            val  address = Url("http://google.com")
            var result = ""

            try {
                 result = client.get {
                    url(address.toString())
                }
            }
            catch(t: Throwable){
                call.respondText ( (if (t.message != null) t.message!! else ""), ContentType.Application.Json )
            }

            call.respondHtml { result }

        }
        get("/api/data") {
            call.response.header("Access-Control-Allow-Origin", "*")
            call.respondText(
                "[\n" +
                        "    {\n" +
                        "        \"id\": 12386,\n" +
                        "        \"ticker\": \"BA US\",\n" +
                        "        \"alpha\": 3.0192,\n" +
                        "        \"benchMarkTicker\": \"SPX\",\n" +
                        "        \"absolutePerformance\": 3.4212,\n" +
                        "        \"benchMarkTickerDesc\": \"S&P 500 Index\",\n" +
                        "        \"benchMarkCurrentPrice\": 2856.6600,\n" +
                        "        \"benchMarkPerformance\": 0.3929,\n" +
                        "        \"convictionId\": 3,\n" +
                        "        \"currentPrice\": 360.2000,\n" +
                        "        \"direction\": \"Long\",\n" +
                        "        \"directionId\": 1,\n" +
                        "        \"entryPrice\": 348.3150,\n" +
                        "        \"reason\": \"Target Price\",\n" +
                        "        \"securityName\": \"Boeing\",\n" +
                        "        \"stockCurrency\": \"USD\",\n" +
                        "        \"stopLoss\": 10.0000,\n" +
                        "        \"stopLossValue\": 313.4835,\n" +
                        "        \"targetPrice\": 360.000,\n" +
                        "        \"targetPricePercentage\": 0.0000,\n" +
                        "        \"timeHorizon\" : \"1 week\"\n" +
                        "    },\n" +
                        "    {\n" +
                        "        \"id\": 50001928,\n" +
                        "        \"ticker\": \"BA US\",\n" +
                        "        \"alpha\": 2.544,\n" +
                        "        \"benchMarkTicker\": \"SPX\",\n" +
                        "        \"absolutePerformance\": 1.8837,\n" +
                        "        \"benchMarkTickerDesc\": \"S&P 500 Index\",\n" +
                        "        \"benchMarkCurrentPrice\": 2838.5200,\n" +
                        "        \"benchMarkPerformance\": -0.6607,\n" +
                        "        \"convictionId\": 3,\n" +
                        "        \"currentPrice\": 80.0500,\n" +
                        "        \"direction\": \"Long\",\n" +
                        "        \"directionId\": 1,\n" +
                        "        \"entryPrice\": 78.5700,\n" +
                        "        \"reason\": \"Target Price\",\n" +
                        "        \"securityName\": \"Target Corp.\",\n" +
                        "        \"stockCurrency\": \"USD\",\n" +
                        "        \"stopLoss\": 5.0000,\n" +
                        "        \"stopLossValue\": 74.6415,\n" +
                        "        \"targetPrice\": 80.000,\n" +
                        "        \"targetPricePercentage\": 0.0000,\n" +
                        "        \"timeHorizon\" : \"1 Month\"\n" +
                        "    },\n" +
                        "    {\n" +
                        "        \"id\": 50002278,\n" +
                        "        \"ticker\": \"ROKU US\",\n" +
                        "        \"alpha\": 2.6737,\n" +
                        "        \"benchMarkTicker\": \"SPX\",\n" +
                        "        \"absolutePerformance\": 3.0274,\n" +
                        "        \"benchMarkTickerDesc\": \"S&P 500 Index\",\n" +
                        "        \"benchMarkCurrentPrice\": 2909.3500,\n" +
                        "        \"benchMarkPerformance\": 0.3537,\n" +
                        "        \"convictionId\": 2,\n" +
                        "        \"currentPrice\": 130.0000,\n" +
                        "        \"direction\": \"Long\",\n" +
                        "        \"directionId\": 1,\n" +
                        "        \"entryPrice\": 78.5700,\n" +
                        "        \"reason\": \"Target Price\",\n" +
                        "        \"securityName\": \"Target Corp.\",\n" +
                        "        \"stockCurrency\": \"USD\",\n" +
                        "        \"stopLoss\": 5.0000,\n" +
                        "        \"stopLossValue\": 119.8710,\n" +
                        "        \"targetPrice\": 130.000,\n" +
                        "        \"targetPricePercentage\": 0.0000,\n" +
                        "        \"timeHorizon\" : \"1 Month\"\n" +
                        "    },\n" +
                        "    \n" +
                        "    {\n" +
                        "        \"id\": 500001841,\n" +
                        "        \"ticker\": \"KR US\",\n" +
                        "        \"alpha\": 12.2780,\n" +
                        "        \"benchMarkTicker\": \"SPX\",\n" +
                        "        \"absolutePerformance\": -0.3712,\n" +
                        "        \"benchMarkTickerDesc\": \"S&P 500 Index\",\n" +
                        "        \"benchMarkCurrentPrice\": 2944.6300,\n" +
                        "        \"benchMarkPerformance\": -2.5861,\n" +
                        "        \"convictionId\": 3,\n" +
                        "        \"currentPrice\": 21.9900,\n" +
                        "        \"direction\":\"Short\",\n" +
                        "        \"directionId\":3,\n" +
                        "        \"entryPrice\": 24.3500,\n" +
                        "        \"reason\": \"Target Price\",\n" +
                        "        \"securityName\": \"The Kroger Cо.\",\n" +
                        "        \"stockCurrency\": \"USD\",\n" +
                        "        \"stopLoss\": 5.0000,\n" +
                        "        \"stopLossValue\": 25.5675,\n" +
                        "        \"targetPrice\": 22.000,\n" +
                        "        \"targetPricePercentage\":0.0000,\n" +
                        "        \"timeHorizon\": \"1 Month\"\n" +
                        "    }\n" +
                        "]",
                ContentType.Application.Json)
        }

        post("/api/hi"){
            sendReloadSignal()
            call.respond(mapOf("OK" to true))
        }

        post("/api/postidea") {
            val post = call.receive<Idea>()
            ideas.add(post)
            sendReloadSignal()
            call.respond(mapOf("OK" to true))
        }
        post("/api/updateidea") {
            val post = call.receive<Idea>()
            var idea = ideas.find { it.id == post.id }
            var index = ideas.indexOf(idea)
            ideas[index] = post
           sendReloadSignal()
            call.respond(mapOf("OK" to true))
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

           /* for (frame in incoming) {
                when (frame) {
                    is Frame.Text -> {

                        val text = frame.readText()
                        //frame.
                        if (text == "Android client connecting") {
                            wssessions.add(this)
                            this.send(Frame.Text("server acknowledged client connection"))
                            for (wssession in wssessions) {
                                wssession.send(Frame.Text("server received this message from client: $text"))
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

            */
        }
    }
}
