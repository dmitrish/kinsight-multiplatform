package com.kinsight.kinsightmultiplatform.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable


@Serializable data class GraphModel (
    @SerialName("Benchmark")
    val benchmark : List<TickModel>,
    @SerialName("Ticker")
    val ticker: List<TickModel>,
    @SerialName("IdeaAge")
    val ideaAge: Int,
    @SerialName("IntervalOption")
    val intervalOption: String
)


