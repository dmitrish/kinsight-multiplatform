package com.kinsight.kinsightmultiplatform.extensions

import com.kinsight.kinsightmultiplatform.models.TickModel
import java.util.*

fun TickModel.tickDate() : Date {
    val numericString = this.sourceDate.toCharArray()
        .filter { it.isDigit() }
        .joinToString(separator = "")
    val date = Date(numericString.toLong())
    return date
}
