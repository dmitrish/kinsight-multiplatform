package com.kinsight.kinsightmultiplatform.ViewModels

import android.app.Application
import android.util.Log
import androidx.lifecycle.*
import com.kinsight.kinsightmultiplatform.api.WsClient
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.repository.IdeaRepository
import kotlinx.coroutines.*

class IdeasViewModel (application: Application, userName: String) : AndroidViewModel(application) {

    //private val  wsClient by lazy { WsClient("ws://10.0.2.2:8081/ws")}
    //region private area
    private val ideaRep by lazy { IdeaRepository() }

    private val ideas: MutableLiveData<List<IdeaModel>> by lazy {
        MutableLiveData<List<IdeaModel>>().also {
           loadIdeas("ideaCreator")
        }
    }

    private fun loadIdeas() {
        Log.i("APP", "loading ideas")
        CoroutineScope(Dispatchers.IO).launch {
           ideas.postValue( ideaRep.fetchIdeas())
        }
    }

    private fun loadIdeas(createdBy: String?) {
        viewModelScope.launch(){

            var ideasTemp : List<IdeaModel>? = null
           // for (x in 1..400) {
            withContext(Dispatchers.IO) {
                ideasTemp = ideaRep.fetchIdeas()
            }
            ideas.value = ideasTemp

            withContext(Dispatchers.IO) {
                ideaRep.receive("10.0.2.2", 8081) {
                    println("android app received from server: $it")
                    if (it == "reload") {
                        loadIdeas("s")
                    }
                }
            }
        }
    }
    //endregion

    //region public area
    fun getIdeas(): LiveData<List<IdeaModel>> = ideas

    fun getIdea(id: Int) = ideas.value!!.filter { it.id == id }.single()
    //endregion
}