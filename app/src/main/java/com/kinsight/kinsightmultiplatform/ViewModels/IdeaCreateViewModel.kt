package com.kinsight.kinsightmultiplatform.ViewModels

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.kinsight.kinsightmultiplatform.BuildConfig
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.models.TickerPriceModel
import com.kinsight.kinsightmultiplatform.repository.IdeaRepository
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class IdeaCreateViewModel : ViewModel() {
    private val serverApiUrl = BuildConfig.url

    private val repository by lazy { IdeaRepository(serverApiUrl) }

    private  var selectedTickerPriceModel = MutableLiveData<TickerPriceModel>()

    fun saveIdea(ideaModel : IdeaModel) {
        Log.i("APP", "saving idea: $ideaModel")
        CoroutineScope(Dispatchers.IO).launch {
            repository.saveIdea(ideaModel)
        }
    }

    fun fetchTickerPrice(ticker : String) {
        Log.i("APP", "fetching ticker price: $ticker")
        CoroutineScope(Dispatchers.IO).launch {
           val priceModel = repository.fetchTickerPrice(ticker)
            println("Price Model: $priceModel")
            selectedTickerPriceModel.postValue(priceModel)
        }
    }

    fun getTickerPrice(): LiveData<TickerPriceModel> = selectedTickerPriceModel
}