package com.kinsight.kinsightmultiplatform.repository


import com.kinsight.kinsightmultiplatform.ApplicationDispatcher
import com.kinsight.kinsightmultiplatform.api.IdeaApi
import com.kinsight.kinsightmultiplatform.models.GraphModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.models.TickerModel
import com.kinsight.kinsightmultiplatform.models.TickerPriceModel
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch



class IdeaRepository(val baseUrl: String = "https://alphacapture.appspot.com") {

    private val ideaApi = IdeaApi(baseUrl)



    suspend fun fetchIdeas(): List<IdeaModel> {
        val ideas = ideaApi.fetchIdeas()
        return ideas
    }

    @Suppress("unused")
    suspend fun receive(host: String, port: Int, onReceive: (String) -> Unit ) {
        ideaApi.receive(host, port, onReceive)
    }

    @Suppress("unused")
    fun fetchIdeas(success: (List<IdeaModel>) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {
            success(fetchIdeas())
        }
    }

    @Suppress("unused")
    suspend fun fetchTickers(tickerFilter: String): List<TickerModel> {
        val tickers = ideaApi.fetchTickers(tickerFilter)
        return tickers
    }

    @Suppress("unused")
    fun fetchTickers(tickerFilter: String, success: (List<TickerModel>) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {
            success(fetchTickers(tickerFilter))
        }
    }

    @Suppress("unused")
    suspend fun fetchGraph(ideaId: Int): GraphModel {
        val graph = ideaApi.fetchGraph(ideaId)
        return graph
    }

    @Suppress("unused")
    fun fetchGraph(ideaId: Int, success: (GraphModel) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {
            success(fetchGraph(ideaId))
        }
    }

    @Suppress("unused")
    suspend fun saveIdea(ideaModel: IdeaModel): Unit {
       ideaApi.saveIdea(ideaModel)
    }

    @Suppress("unused", "unused_parameter")
    fun saveIdea(ideaModel: IdeaModel, success: () -> Unit){
        GlobalScope.launch (ApplicationDispatcher){
            saveIdea(ideaModel)
        }
    }

    @Suppress("unused")
    suspend fun closeIdea(ideaModel: IdeaModel): Unit {
        ideaApi.closeIdea(ideaModel)
    }

    @Suppress("unused", "unused_parameter")
    fun closeIdea(ideaModel: IdeaModel, success: () -> Unit){
        GlobalScope.launch (ApplicationDispatcher){
            closeIdea(ideaModel)
        }
    }


    @Suppress("unused")
    suspend fun fetchTickerPrice(ticker: String): TickerPriceModel {
        val tickerPriceModel = ideaApi.fetchTickerPrice(ticker)
        return tickerPriceModel
    }

    @Suppress("unused")
    fun fetchTickerPrice(ticker: String, success: (TickerPriceModel) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {
            success(fetchTickerPrice(ticker))
        }
    }




}
