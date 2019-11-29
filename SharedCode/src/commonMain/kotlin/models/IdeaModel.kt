package com.kinsight.kinsightmultiplatform.models

import kotlinx.serialization.*

@Serializable data class IdeaModel (
    @SerialName("id")
    val id: Int,
    @SerialName("securityName")
    val securityName: String,
    @SerialName("securityTicker")
    val securityTicker: String,
    @SerialName("alpha")
    var alpha: Double,
    @SerialName("benchMarkTicker")
    var benchMarkTicker: String,
   // @SerialName("benchMarkTickerDesk")
   // var benchMarkTickerDesk: String,
    @SerialName("benchMarkCurrentPrice")
    var benchMarkCurrentPrice: Double,
    @SerialName("benchMarkPerformance")
    var benchMarkPerformance: Double,
    @SerialName("convictionId")
    var convictionId: Int,
    @SerialName("currentPrice")
    var currentPrice: Double,

    @SerialName("direction")
    var direction: String,
    @SerialName("directionId")
    var directionId: Int,
    @SerialName("entryPrice")
    var entryPrice: Double,
    @SerialName("reason")
    var reason: String,
    @SerialName("stockCurrency")
    var stockCurrency: String,
    @SerialName("stopLoss")
    var stopLoss: Int,
    @SerialName("stopLossValue")
    var stopLossValue: Double,
    @SerialName("targetPrice")
    var targetPrice: Double,
    @SerialName("targetPricePercentage")
    var targetPricePercentage: Double,
    @SerialName("timeHorizon")
    var timeHorizon: String,
    @SerialName("createdBy")
    var createdBy: String,
    @SerialName("createdFrom")
    var createdFrom: String,
    @SerialName("previousCurrentPrice")
    var previousCurrentPrice: Double,
    @SerialName ("isActive")
    var isActive: Boolean
)

interface Idea {
    val id: Int
    val securityName: String
    val alpha: Double
}
