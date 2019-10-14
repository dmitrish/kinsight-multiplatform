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


    suspend fun fetchIdeas(): List<IdeaModel> {
        val jsonArrayString = client.get<String> {
            url("$baseUrl/api/ideas")
        }
        return Json.nonstrict.parse(IdeaModel.serializer().list, jsonArrayString)
    }


}