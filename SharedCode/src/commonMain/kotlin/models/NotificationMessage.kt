package com.kinsight.kinsightmultiplatform.models

data class NotificationMessage(val messageHeader: String, val message: String,
                                val by: String, val from: String, val ideaId: Int)