package com.kinsight.kinsightmultiplatform

import android.content.Intent
import android.graphics.drawable.AnimationDrawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.TextView
import com.kinsight.kinsightmultiplatform.resources.Strings
import com.kinsight.kinsightmultiplatform.views.FullScreenActivity
import kotlinx.android.synthetic.main.activity_welcome.*
import androidx.core.app.ComponentActivity.ExtraData
import androidx.core.content.ContextCompat.getSystemService
import android.icu.lang.UCharacter.GraphemeClusterBreak.T
import android.view.animation.CycleInterpolator


class WelcomeActivity : FullScreenActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_welcome)

        animate()
        initNavigation()
        displayWelcomeMessage()
        animateText()
    }

    private fun displayWelcomeMessage() {
        welcome_text.text = Strings.welcomeMessage
    }

    private fun initNavigation() {
        findViewById<TextView>(R.id.welcome_text).setOnClickListener {
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
        }
    }

    private fun animate() {
        val animDrawable = root_layout.background as AnimationDrawable
        animDrawable.setEnterFadeDuration(10)
        animDrawable.setExitFadeDuration(5000)
        animDrawable.start()
    }

    private fun animateText(){

        welcome_text.alpha = 0f
       welcome_text.animate().apply {
            duration = 3000
            alpha(1f)
            start()
        }

        val durationMs = 60000L
        val cycleDurationMs = 5000f
        exunum.alpha = 0f
        powered.alpha = 0f
        exunum.animate().apply {
           // interpolator = CycleInterpolator(durationMs / cycleDurationMs)
            duration = 5000
            alpha(1f)
            start()
        }

        powered.animate().apply {
            duration = 5000
            alpha(1f)
            start()
       }



    }
}
