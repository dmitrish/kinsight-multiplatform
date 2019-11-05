package com.kinsight.kinsightmultiplatform.ViewModels

import android.app.Application
import android.util.Log
import androidx.lifecycle.*
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.repository.IdeaRepository
import kotlinx.coroutines.*

class IdeasViewModel (application: Application, userName: String) : AndroidViewModel(application) {

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
            withContext(Dispatchers.IO) {
                ideasTemp = ideaRep.fetchIdeas()
            }
            ideas.value = ideasTemp
        }
    }
    //endregion

    //region public area
    fun getIdeas(): LiveData<List<IdeaModel>> = ideas

    fun getIdea(id: Int) = ideas.value!!.filter { it.id == id }.single()
    //endregion
}