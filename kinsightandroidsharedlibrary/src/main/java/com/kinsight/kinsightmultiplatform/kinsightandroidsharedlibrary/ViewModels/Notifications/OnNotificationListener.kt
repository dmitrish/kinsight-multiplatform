package com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Notifications

import com.kinsight.kinsightmultiplatform.models.NotificationMessage

interface OnNotificationListener {
    fun onNotification(notificationMessage: NotificationMessage)
}