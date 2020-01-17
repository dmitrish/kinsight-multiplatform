package com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels

import android.app.Activity
import android.app.Application
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Notifications.OnNotificationListener

class IdeaViewModelFactory(val application: Application, val userName: String, val notificationListener: OnNotificationListener) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return IdeasViewModel(application, userName, notificationListener) as T
    }
}