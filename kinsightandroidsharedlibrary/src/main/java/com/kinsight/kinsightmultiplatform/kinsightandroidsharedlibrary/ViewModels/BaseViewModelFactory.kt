package com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels


import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.kinsight.kinsightmultiplatform.models.IdeaModel

class BaseViewModelFactory<T>(val creator: () -> T) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return creator() as T
    }
}
