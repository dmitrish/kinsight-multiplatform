package com.kinsight.kinsightmultiplatform.repository


import com.kinsight.kinsightmultiplatform.ApplicationDispatcher
import com.kinsight.kinsightmultiplatform.api.IdeaApi
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch


class IdeaRepository {

    private val ideaApi = IdeaApi()


    suspend fun fetchIdeas(): List<IdeaModel> {
        val ideas = ideaApi.fetchIdeas()
        return ideas
    }

    suspend fun receive(host: String, port: Int, callback: (String) -> Unit ) {
        ideaApi.receive(host, port, callback)
    }

    fun fetchIdeas(success: (List<IdeaModel>) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {
            success(fetchIdeas())
        }
    }




}
