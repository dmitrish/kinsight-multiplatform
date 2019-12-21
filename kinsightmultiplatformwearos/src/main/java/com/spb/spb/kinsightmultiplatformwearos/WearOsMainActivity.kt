package com.spb.spb.kinsightmultiplatformwearos

import android.content.Intent
import android.os.Bundle
import android.support.wearable.activity.WearableActivity
import android.view.KeyEvent
import android.widget.ImageView
import android.widget.TextView
import kotlinx.android.synthetic.main.activity_wear_os_main.*

class WearOsMainActivity : WearableActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_wear_os_main)

        // Enables Always-on
      //  setAmbientEnabled()

        initNavigation()

        val intent = Intent(this, WearIdeasActivity::class.java)
       // startActivity(intent)
        appLogo.requestFocus()
       // this.fo
    }

    private fun initNavigation() {
       /* findViewById<TextView>(R.id.exunum).setOnClickListener {
            val intent = Intent(this, WearIdeasActivity::class.java)
            startActivity(intent)
        }

        findViewById<ImageView>(R.id.appLogo).setOnClickListener {
            val intent = Intent(this, WearIdeasActivity::class.java)
            startActivity(intent)
        }*/



        mainLayout.setOnClickListener{
            val intent = Intent(this, WearIdeasActivity::class.java)
            startActivity(intent)
          //  finish()
        }



    }
    override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
        when (keyCode) {
            KeyEvent.KEYCODE_SPACE -> {
                val intent = Intent(this, WearIdeasActivity::class.java)
                startActivity(intent)
              //  finish()
                return true
            }
            else -> return super.onKeyDown(keyCode, event)
        }
    }
}
