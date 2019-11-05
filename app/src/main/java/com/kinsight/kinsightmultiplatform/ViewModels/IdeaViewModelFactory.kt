package com.kinsight.kinsightmultiplatform.ViewModels

import android.app.Application
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider

class IdeaViewModelFactory(val application: Application, val userName: String) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return IdeasViewModel(application, userName) as T
    }
}