package com.kinsight.kinsightmultiplatform
import com.kinsight.kinsightmultiplatform.models.*

actual class IdeaModelLogicDecorator actual constructor (private var ideaModel: IdeaModel){

    actual fun getConviction() : String {
        return when (ideaModel.convictionId) {
            1 -> "High"
            2 -> "Medium"
            3 -> "Low"
            else -> "NA"
        }
    }

    actual fun getDisplayValueForAlpha(): String {
        return ideaModel.alpha.toString()
    }

    actual fun getDisplayValueForPrice(priceKind: PriceKind): String{
        val result = when (priceKind){
            PriceKind.CURRENT -> ideaModel.currentPrice.toString()
            PriceKind.PREVIOUS -> ideaModel.previousCurrentPrice.toString()
            PriceKind.TARGET -> ideaModel.targetPrice.toString()
        }
        return "$$result"

    }
}