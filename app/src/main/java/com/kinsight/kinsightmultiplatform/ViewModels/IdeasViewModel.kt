package com.kinsight.kinsightmultiplatform.ViewModels

import android.app.Application
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.notifications.NotificationHelper
import com.kinsight.kinsightmultiplatform.repository.IdeaRepository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class IdeasViewModel (application: Application, private val userName: String) : AndroidViewModel(application) {
    //private val serverApiUrl =  "http://$SERVER_URL_LOCAL_BASE_FOR_EMULATOR:$PORT/api/ideas"
    //region private area
    //private val serverApiUrl =  "https://alphacapture.appspot.com"

    private val serverApiUrl =  "http://10.0.2.2:8081"

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
        ideas.value = ideasTemp

        ///this is temp, just to test ticker search
        withContext(Dispatchers.IO){
            val tickers = ideaRep.fetchTickers("AB")
            println("tickers: $tickers")
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
            ideaRep.receive("10.0.2.2", 8081) {
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
    //endregion
}