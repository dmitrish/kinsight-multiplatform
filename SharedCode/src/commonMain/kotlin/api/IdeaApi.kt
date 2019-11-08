package com.kinsight.kinsightmultiplatform.api


import com.kinsight.kinsightmultiplatform.models.IdeaModel
import io.ktor.client.HttpClient
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.client.request.url
import kotlinx.serialization.KSerializer
import kotlinx.serialization.internal.StringSerializer
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import kotlinx.serialization.list
import kotlinx.serialization.map
import io.ktor.client.features.websocket.WebSockets
import io.ktor.client.features.websocket.ws
import io.ktor.http.HttpMethod
import io.ktor.http.cio.websocket.Frame
import io.ktor.http.cio.websocket.readBytes
import io.ktor.http.cio.websocket.readText
import kotlinx.coroutines.channels.consumeEach

//import io.ktor.client.engine.ci


class IdeaApi(val baseUrl: String = "https://alphacapture.appspot.com") {


    private val client by lazy {
        HttpClient() {
            install(JsonFeature) {
                serializer = KotlinxSerializer(Json(JsonConfiguration(strictMode = false))).apply {
                    setMapper(IdeaModel::class, IdeaModel.serializer())

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


    suspend fun receive(hostn: String, portn: Int, callback: (String)-> Unit){
        try {
            wsclient.ws (
                method = HttpMethod.Get,
                host = hostn,
                port = portn, path = "/ws"
            ) {
                send(Frame.Text("Android client connecting"))

                val frame = incoming.receive()
                when (frame) {
                    is Frame.Text -> println(frame.readText())
                    is Frame.Binary -> println(frame.readBytes())
                }

                while (true) {


                    val frame = incoming.receive()
                    if (frame is Frame.Text) {
                        println("Android client received: " + frame.readText())
                        callback(frame.readText())
                    }
                }

                /*while (0 == 0) {
                    incoming.consumeEach { frame ->
                        if (frame is Frame.Text) {
                            println("Client received: " + frame.readText())
                        }
                    }
                }*/

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

    suspend fun fetchIdea(id: Int): IdeaModel {
        val jsonString = client.get<String> {
            url("$baseUrl/api/ideas/${id}")
        }
        return Json.nonstrict.parse(IdeaModel.serializer(), jsonString)
    }


}