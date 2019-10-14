package com.kinsight.kinsightmultiplatform

import platform.UIKit.UIDevice

import platform.*

actual fun platformName(): String {
    return UIDevice.currentDevice.systemName() +
            " " +
            UIDevice.currentDevice.systemVersion
}

