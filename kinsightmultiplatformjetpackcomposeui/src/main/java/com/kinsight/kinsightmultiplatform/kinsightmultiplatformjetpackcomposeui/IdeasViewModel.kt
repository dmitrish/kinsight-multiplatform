package com.kinsight.kinsightmultiplatform.kinsightmultiplatformjetpackcomposeui

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.kinsight.kinsightmultiplatform.api.IdeaApi
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.repository.IdeaRepository
import kotlinx.coroutines.launch

class IdeasViewModel() : ViewModel() {
    private val serverApiUrl = "http://35.239.179.43:8081"

    private val ideaRep by lazy { IdeaRepository(serverApiUrl) }

    val ideas = MutableLiveData<List<IdeaModel>>(emptyList())

    init {
        viewModelScope.launch {
            val data = ideaRep.fetchIdeas()
            ideas.value = data
        }
    }
}