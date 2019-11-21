package com.kinsight.kinsightmultiplatform.views

import android.os.Bundle
import android.os.PersistableBundle
import androidx.appcompat.app.AppCompatActivity
import com.kinsight.kinsightmultiplatform.R
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

    fun getFishImageForAlpha(alpha: Double) : Int{
        return when {
            alpha >= 4 -> R.drawable.ic_fish_green
            alpha >= 3 -> R.drawable.ic_fish_yellow
            alpha >= 1 -> R.drawable.ic_fish_pale_yellow
            alpha < 1 -> R.drawable.ic_fish_superhot
            else -> R.drawable.ic_fish_blue
        }
    }

}