package com.kinsight.kinsightmultiplatform

import com.kinsight.kinsightmultiplatform.models.IdeaModel
import platform.UIKit.UIDevice

import platform.*

actual fun platformName(): String {
    return UIDevice.currentDevice.systemName() +
            " " +
            UIDevice.currentDevice.systemVersion
}
actual interface Parcelable

//actual interface Codable


