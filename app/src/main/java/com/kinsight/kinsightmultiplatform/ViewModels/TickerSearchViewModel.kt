package com.kinsight.kinsightmultiplatform.ViewModels

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.models.TickerModel
import com.kinsight.kinsightmultiplatform.repository.IdeaRepository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class TickerSearchViewModel: ViewModel() {
    private val serverApiUrl =  "https://alphacapture.appspot.com"

    private val repository by lazy { IdeaRepository(serverApiUrl) }

    var lastFilter = ""

    private val tickers: MutableLiveData<List<TickerModel>> by lazy {
        MutableLiveData<List<TickerModel>>().also {
           //do nothing
        }
    }

    private val tickerSearchModel: MutableLiveData<TickerSearchModel> by lazy {
        MutableLiveData<TickerSearchModel>().also {
            //do nothing
        }
    }

     fun loadTickers(tickerFilter: String) {
         lastFilter = tickerFilter
        Log.i("APP", "loading tickers")
        CoroutineScope(Dispatchers.IO).launch {
            tickers.postValue( repository.fetchTickers(tickerFilter))
            tickerSearchModel.postValue(TickerSearchModel(tickerFilter, repository.fetchTickers(tickerFilter) ))
        }
    }

    fun getTickers(): LiveData<List<TickerModel>> = tickers

    fun getTickerSearchModel(): LiveData<TickerSearchModel> = tickerSearchModel

}