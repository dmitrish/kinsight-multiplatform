package com.kinsight.kinsightmultiplatform.ViewModels

import com.kinsight.kinsightmultiplatform.models.TickerModel

class TickerSearchModel (
    val searchFilter: String = "",
    val tickers: List<TickerModel> = mutableListOf()
)