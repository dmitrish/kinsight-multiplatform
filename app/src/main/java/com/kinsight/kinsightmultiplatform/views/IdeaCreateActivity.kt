package com.kinsight.kinsightmultiplatform.views

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.kinsight.kinsightmultiplatform.Constans.PICK_TICKER_REQUEST
import com.kinsight.kinsightmultiplatform.R
import kotlinx.android.synthetic.main.activity_idea_create.*
import kotlinx.android.synthetic.main.activity_ticker_search.*

class IdeaCreateActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_idea_create)

        chooseTicker.setOnClickListener {
            val intent = Intent(this, TickerSearchActivity::class.java)
            startActivityForResult(intent, PICK_TICKER_REQUEST)
        }
    }

    fun onRadioButtonClicked(){

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        // Check which request we're responding to
        if (requestCode == PICK_TICKER_REQUEST) {
            // Make sure the request was successful
            if (resultCode == Activity.RESULT_OK) {
               chooseTicker.text = data?.getStringExtra("ticker")
             }
        }

        super.onActivityResult(requestCode, resultCode, data)
    }
}
