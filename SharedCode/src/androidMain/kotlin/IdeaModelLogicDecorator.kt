package com.kinsight.kinsightmultiplatform

import com.kinsight.kinsightmultiplatform.models.IdeaModel
import java.math.RoundingMode
import java.text.DecimalFormat

actual class IdeaModelLogicDecorator actual constructor (private var ideaModel: IdeaModel){

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
}