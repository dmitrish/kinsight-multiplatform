package com.kinsight.kinsightmultiplatform.views

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Toast
import com.kinsight.kinsightmultiplatform.Constans.PICK_TICKER_REQUEST
import com.kinsight.kinsightmultiplatform.R
import com.kinsight.kinsightmultiplatform.ViewModels.IdeaCreateViewModel
import com.kinsight.kinsightmultiplatform.extensions.getViewModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import kotlinx.android.synthetic.main.activity_idea_create.*


class IdeaCreateActivity : FullScreenActivity() {

    private var isBear: Boolean = false
    private var isBull: Boolean = false

    private val viewModel by lazy { getViewModel {IdeaCreateViewModel()}}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_idea_create)

        val startIntent = intent
        val nextId = startIntent.getIntExtra("nextId", 0)


        chooseTicker.setOnClickListener {
            val intent = Intent(this, TickerSearchActivity::class.java)
            startActivityForResult(intent, PICK_TICKER_REQUEST)
        }

        imageBear.setOnClickListener{

            if (!isBear) {
                imageBear.animate().apply {
                    duration = 1000
                    xBy(120f)
                    scaleXBy(0.5F)
                    scaleYBy(0.5F)
                    start()
                }
                imageBull.animate().apply {
                    duration = 1000
                    xBy(120f)
                    scaleXBy(-0.2F)
                    scaleYBy(-0.2F)
                    start()
                }
                isBear = true

            }
            else {
                    imageBear.animate().apply {
                        duration = 1000
                        xBy(-120f)
                        scaleXBy(-0.5F)
                        scaleYBy(-0.5F)
                        start()
                    }
                    imageBull.animate().apply {
                        duration = 1000
                        xBy(-120f)
                        scaleXBy(0.2F)
                        scaleYBy(0.2F)
                        start()
                    }
                    isBear = false
                }
            isBull = false
        }

        imageBull.setOnClickListener{
            if (!isBull && !isBear) {
                imageBull.animate().apply {
                    duration = 1000
                    xBy(-120f)
                    scaleXBy(0.5F)
                    scaleYBy(0.5F)
                    start()
                }
                imageBear.animate().apply {
                    duration = 1000
                    xBy(-120f)
                    scaleXBy(-0.2F)
                    scaleYBy(-0.2F)
                    start()
                }
                isBull = true
            }
            else if (!isBull && isBear) {
                imageBull.animate().apply {
                    duration = 1000
                    xBy(-240f)
                    scaleXBy(0.7F)
                    scaleYBy(0.7F)
                    start()
                }
                imageBear.animate().apply {
                    duration = 1000
                    xBy(-240f)
                    scaleXBy(-0.7F)
                    scaleYBy(-0.7F)
                    start()
                }
                isBull = true
            }
            else {
                imageBull.animate().apply {
                    duration = 1000
                    xBy(120f)
                    scaleXBy(-0.5F)
                    scaleYBy(-0.5F)
                    start()
                }
                imageBear.animate().apply {
                    duration = 1000
                    xBy(-120f)
                    scaleXBy(0.2F)
                    scaleYBy(0.2F)
                    start()
                }
                isBull = false
            }
            isBear = false
        }


        saveIdea.setOnClickListener{
            try {
                val securityTicker = chooseTicker.text.toString()
                val targetPrice = targetPrice.text.toString().plus(".00").toDouble()
                val stopLoss = stopLoss.text.toString().toInt()
                val newIdea = IdeaModel(
                    id = nextId,
                    alpha = 0.0,
                    benchMarkTicker = "SPX",
                    //benchMarkTickerDesk= "SP 500 Index",
                    benchMarkCurrentPrice = 2856.66,
                    benchMarkPerformance = 0.392,
                    convictionId = 1,
                    currentPrice = 24.59,
                    direction = "Long",
                    directionId = 1,
                    entryPrice = 24.59,
                    reason = "Target Price",
                    securityName = securityTicker,
                    securityTicker = securityTicker,
                    stockCurrency = "USD",
                    stopLoss = stopLoss,
                    stopLossValue = 313.4823,
                    targetPrice = targetPrice,
                    targetPricePercentage = 0.0,
                    timeHorizon = "1 Week",
                    createdBy = "Dmitri - from Android"

                )

                viewModel.saveIdea(newIdea)
                finish()
            }
            catch(e: Throwable){
                Toast.makeText(this,"Failed to save: ${e.message}", Toast.LENGTH_LONG)
                    .show()
                Log.e("IDEA_", e.message + e.stackTrace)
            }
        }
    }

    fun onRadioButtonClicked(v: View){

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
