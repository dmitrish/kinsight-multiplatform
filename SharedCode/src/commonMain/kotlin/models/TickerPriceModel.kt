package com.kinsight.kinsightmultiplatform.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable
data class TickerPriceModel (
    @SerialName("symbol")
    val symbol: String,
    @SerialName("companyName")
    val companyName: String,
    @SerialName("latestPrice")
    val latestPrice: Double,
    @SerialName("lastTradeTime")
    val lastTradeTime: Long
)