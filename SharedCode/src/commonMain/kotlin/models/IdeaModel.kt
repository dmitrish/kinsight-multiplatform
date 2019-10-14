package com.kinsight.kinsightmultiplatform.models

import kotlinx.serialization.*

@Serializable data class IdeaModel(
    @SerialName("id")
    val id: Int,
    @SerialName("securityName")
    val securityName: String,
    @SerialName("alpha")
    val alpha: Double)
