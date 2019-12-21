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
        return "NA"
    }

    actual fun getDisplayValueForPrice(priceKind: PriceKind): String{

        return "NA"

    }
}