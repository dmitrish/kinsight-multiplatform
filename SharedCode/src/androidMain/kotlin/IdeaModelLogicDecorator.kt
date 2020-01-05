package com.kinsight.kinsightmultiplatform

import com.kinsight.kinsightmultiplatform.models.*
import io.ktor.client.HttpClient
import io.ktor.client.engine.cio.CIO
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.features.logging.DEFAULT
import io.ktor.client.features.logging.LogLevel
import io.ktor.client.features.logging.Logger
import io.ktor.client.features.logging.Logging
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import java.math.RoundingMode
import java.text.DecimalFormat

actual class IdeaModelLogicDecorator actual constructor (private var ideaModel: IdeaModel){


    private val client by lazy {
        HttpClient(CIO) {
            install(Logging) {
                logger = Logger.DEFAULT
                level = LogLevel.HEADERS
            }
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

    private val df = DecimalFormat("00.00").also {
        it.roundingMode =  RoundingMode.CEILING
    }
    /*init{

        df.roundingMode = RoundingMode.CEILING
    }*/

    actual fun getConviction() : String {
        return when (ideaModel.convictionId) {
            1 -> "High"
            2 -> "Medium"
            3 -> "Low"
            else -> "NA"
        }
    }

    actual fun getDisplayValueForAlpha(): String {
        return df.format(ideaModel.alpha)
    }

    actual fun getDisplayValueForPrice(priceKind: PriceKind): String{
        val result = when (priceKind){
            PriceKind.CURRENT -> df.format(ideaModel.currentPrice)
            PriceKind.PREVIOUS -> df.format(ideaModel.previousCurrentPrice)
            PriceKind.TARGET -> df.format(ideaModel.targetPrice)
        }
         return "$$result"

    }
}