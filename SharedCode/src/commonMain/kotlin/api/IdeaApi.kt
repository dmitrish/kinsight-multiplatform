package com.kinsight.kinsightmultiplatform.api


import com.kinsight.kinsightmultiplatform.models.*
import io.ktor.client.HttpClient
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.get
import io.ktor.client.request.url
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import kotlinx.serialization.list
import io.ktor.client.features.websocket.WebSockets
import io.ktor.client.features.websocket.ws
import io.ktor.client.request.post
import io.ktor.http.HttpMethod
import io.ktor.http.cio.websocket.Frame
import io.ktor.http.cio.websocket.readText



class IdeaApi(val baseUrl: String = "https://alphacapture.appspot.com") {


    private val client by lazy {
        HttpClient() {
            install(JsonFeature) {
                serializer = KotlinxSerializer(Json(JsonConfiguration(strictMode = false))).apply {
                    setMapper(IdeaModel::class, IdeaModel.serializer())
                    setMapper(TickerModel::class, TickerModel.serializer())
                    setMapper(TickModel::class, TickModel.serializer())
                    setMapper(GraphModel::class, GraphModel.serializer())
                    setMapper(TickerPriceModel::class, TickerPriceModel.serializer())
                }
            }
        }
    }

    private val wsclient by lazy {
        HttpClient() {
            install(WebSockets) {
                install(JsonFeature) {
                    serializer =
                        KotlinxSerializer(Json(JsonConfiguration(strictMode = false))).apply {
                            setMapper(IdeaModel::class, IdeaModel.serializer())

                        }
                }
            }
        }
    }


    suspend fun receive(hostn: String, portn: Int, onReceive: (String)-> Unit){
        try {
            wsclient.ws (
                method = HttpMethod.Get,
                host = hostn,
                port = portn, path = "/ws"
            ) {
                send(Frame.Text("Android client connecting"))

               /* val frame = incoming.receive()
                when (frame) {
                    is Frame.Text -> println(frame.readText())
                    is Frame.Binary -> println(frame.readBytes())
                }*/

                while (true) {
                    val frame = incoming.receive()
                    if (frame is Frame.Text) {
                        val text = frame.readText()
                        println("Android client received: $text")
                        onReceive(text)
                    }
                }
            }
        }
        catch(e: Throwable){
            println(e.message)
        }

        println("exited ws listener")
    }

    suspend fun fetchIdeas(): List<IdeaModel> {
        val jsonArrayString = client.get<String> {
            url("$baseUrl/api/ideas")
        }
        return Json.nonstrict.parse(IdeaModel.serializer().list, jsonArrayString)
    }

    suspend fun fetchTickers(tickerFilter: String): List<TickerModel> {
        val jsonArrayString = client.get<String> {
            url("$baseUrl/api/ticker/$tickerFilter")
        }
        return Json.nonstrict.parse(TickerModel.serializer().list, jsonArrayString)
    }

    suspend fun fetchIdea(id: Int): IdeaModel {
        val jsonString = client.get<String> {
            url("$baseUrl/api/ideas/${id}")
        }
        return Json.nonstrict.parse(IdeaModel.serializer(), jsonString)
    }

    suspend fun fetchTickerPrice(ticker: String): TickerPriceModel {
        val jsonString = client.get<String> {
            url("$baseUrl/api/stock/quote/${ticker}")
        }
        return Json.nonstrict.parse(TickerPriceModel.serializer(), jsonString)
    }

    suspend fun fetchGraph(id: Int): GraphModel {
        val jsonString = client.get<String> {
            url("$baseUrl/api/graph/${id}")
        }
        return Json.nonstrict.parse(GraphModel.serializer(), jsonString)
    }

    suspend fun saveIdea(ideaModel: IdeaModel){
        val json = io.ktor.client.features.json.defaultSerializer()
        client.post<Unit>() {
            url("$baseUrl/api/postidea")
            body = json.write(ideaModel) // Generates an OutgoingContent
        }
    }

    suspend fun closeIdea(ideaModel: IdeaModel){
        val json = io.ktor.client.features.json.defaultSerializer()
        client.post<Unit>() {
            url("$baseUrl/api/closeidea")
            body = json.write(ideaModel) // Generates an OutgoingContent
        }
    }
}