package com.kinsight.kinsightmultiplatform.ViewModels

import android.app.Application
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.kinsight.kinsightmultiplatform.BuildConfig
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.notifications.NotificationHelper
import com.kinsight.kinsightmultiplatform.repository.IdeaRepository
import kotlinx.coroutines.*


class IdeasViewModel (application: Application, private val userName: String) : AndroidViewModel(application) {

    private val serverApiUrl = BuildConfig.url

    private var isSubscribedToLiveUpdates: Boolean = false

    private val ideaRep by lazy { IdeaRepository(serverApiUrl) }

    private val ideas: MutableLiveData<List<IdeaModel>> by lazy {
        MutableLiveData<List<IdeaModel>>().also {
           loadIdeas(userName, !isSubscribedToLiveUpdates)
        }
    }

    private fun loadIdeas() {
        Log.i("APP", "loading ideas")
        CoroutineScope(Dispatchers.IO).launch {
            delay(500)
           ideas.postValue( ideaRep.fetchIdeas())
        }
    }

    private fun loadIdeas(createdBy: String?, subsribeToLiveUpdates: Boolean) {
        viewModelScope.launch(){
            doLoadIdeas()
            if (subsribeToLiveUpdates) {
                subscribeToLiveUpdates()
            }
        }
    }

    private suspend fun doLoadIdeas() {
        var ideasTemp: List<IdeaModel>? = null

        withContext(Dispatchers.IO) {
            ideasTemp = ideaRep.fetchIdeas()
        }
        delay(500)
        ideas.value = ideasTemp

        /*
        * this is temp, just to test ticker search and graph reading
        * will be moved into appropriate places
        * wrapped in try catch so it doesn't crash if you're pointing to a diff server that
        * doesn't support those apis (yet)
        */
        withContext(Dispatchers.IO){
            val tickers = ideaRep.fetchTickers("AB")
            println("tickers: $tickers")
            try {
              //  val graph = ideaRep.fetchGraph(11)
              //  println(graph)
              //  println(graph.benchmark[0].tickDate())
            }
            catch(e: Throwable){
                println(e.message)
            }
        }
    }

    private  fun notifyOnPriceChanged(){
       viewModelScope.launch {
           withContext(Dispatchers.Default) {
               NotificationHelper.sendNotification(
                   getApplication(),
                   "Alpha Capture", "Price Changed", "Price Changed", false
               )
           }
       }
    }

    private suspend fun subscribeToLiveUpdates() {
        withContext(Dispatchers.IO) {
            ideaRep.receive("35.239.179.43", 8081) {
                println("android app received from server: $it")
                if (it == "reload") {
                    loadIdeas()
                    notifyOnPriceChanged()
                }
                isSubscribedToLiveUpdates = true
            }
        }
    }
    //endregion

    //region public area
    fun getIdeas(): LiveData<List<IdeaModel>> = ideas

    fun getIdea(id: Int) = ideas.value!!.filter { it.id == id }.single()

    fun nextId() = ideas.value!!.maxBy { it.id }!!.id
    //endregion
}




