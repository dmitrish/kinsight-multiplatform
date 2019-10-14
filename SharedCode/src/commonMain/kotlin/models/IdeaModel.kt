package com.kinsight.kinsightmultiplatform.models

import kotlinx.serialization.*

@Serializable data class IdeaModel (
    @SerialName("id")
    val id: Int,
    @SerialName("securityName")
    val securityName: String,
    @SerialName("alpha")
    val alpha: Double)

interface Idea {
    val id: Int
    val securityName: String
    val alpha: Double
}
