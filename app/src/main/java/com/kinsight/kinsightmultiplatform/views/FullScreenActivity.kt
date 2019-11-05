package com.kinsight.kinsightmultiplatform.views

import android.os.Bundle
import android.os.PersistableBundle
import androidx.appcompat.app.AppCompatActivity
import com.kinsight.kinsightmultiplatform.uihelpers.makeWindowFullScreen

abstract class FullScreenActivity : AppCompatActivity(){

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        makeWindowFullScreen(this.window)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        makeWindowFullScreen(this.window)
    }

}