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

class WelcomeActivity : FullScreenActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_welcome)

        animate()
        initNavigation()
        displayWelcomeMessage()
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
}
