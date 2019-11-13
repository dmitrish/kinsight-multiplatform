package com.kinsight.kinsightmultiplatform.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class TickerModel (
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