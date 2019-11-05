package com.kinsight.kinsightmultiplatform.uihelpers

import android.view.View
import android.view.Window

fun makeWindowFullScreen(window: Window){
    window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
}