package com.kinsight.kinsightmultiplatform.repository


import com.kinsight.kinsightmultiplatform.ApplicationDispatcher
import com.kinsight.kinsightmultiplatform.api.IdeaApi
import com.kinsight.kinsightmultiplatform.models.GraphModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.models.TickerModel
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch


class IdeaRepository(val baseUrl: String = "https://alphacapture.appspot.com") {

    private val ideaApi = IdeaApi(baseUrl)


    suspend fun fetchIdeas(): List<IdeaModel> {
        val ideas = ideaApi.fetchIdeas()
        return ideas
    }

    suspend fun receive(host: String, port: Int, onReceive: (String) -> Unit ) {
        ideaApi.receive(host, port, onReceive)
    }

    fun fetchIdeas(success: (List<IdeaModel>) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {
            success(fetchIdeas())
        }
    }

    suspend fun fetchTickers(tickerFilter: String): List<TickerModel> {
        val tickers = ideaApi.fetchTickers(tickerFilter)
        return tickers
    }

    fun fetchTickers(tickerFilter: String, success: (List<TickerModel>) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {
            success(fetchTickers(tickerFilter))
        }
    }

    suspend fun fetchGraph(ideaId: Int): GraphModel {
        val graph = ideaApi.fetchGraph(ideaId)
        return graph
    }

    fun fetchGraph(ideaId: Int, success: (GraphModel) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {
            success(fetchGraph(ideaId))
        }
    }




}
