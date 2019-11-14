package com.kinsight.kinsightmultiplatform.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable data class TickModel(
    @SerialName("sourceDate")
    val sourceDate: String,
    @SerialName("x")
    val x: Double,
    @SerialName("y")
    val y: Double
)