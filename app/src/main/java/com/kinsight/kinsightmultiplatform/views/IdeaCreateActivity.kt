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
import androidx.core.app.ComponentActivity.ExtraData
import androidx.core.content.ContextCompat.getSystemService
import android.icu.lang.UCharacter.GraphemeClusterBreak.T
import android.net.Uri

import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Observer
import com.kinsight.kinsightmultiplatform.models.TickerPriceModel


class IdeaCreateActivity : FullScreenActivity(),
    PickIdeaDurationFragment.OnFragmentInteractionListener {


    private var isBear: Boolean = false
    private var isBull: Boolean = false
    private var companyName: String? = null

    private val viewModel by lazy { getViewModel {IdeaCreateViewModel()}}

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_idea_create2)

        val startIntent = intent
        val nextId = startIntent.getIntExtra("nextId", 0)


        chooseTicker.setOnClickListener {
            val intent = Intent(this, TickerSearchActivity::class.java)
            startActivityForResult(intent, PICK_TICKER_REQUEST)
        }


        initViewModelListener()


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
                    securityName = companyName?: securityTicker,
                    securityTicker = securityTicker,
                    stockCurrency = "USD",
                    stopLoss = stopLoss,
                    stopLossValue = 313.4823,
                    targetPrice = targetPrice,
                    targetPricePercentage = 0.0,
                    timeHorizon = "1 Week",
                    createdBy = "Dmitri",
                    createdFrom = "Android",
                    previousCurrentPrice = 24.59,
                    isActive = true

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

    private fun initViewModelListener() {
        viewModel.getTickerPrice().observe (
            this,
            Observer<TickerPriceModel> { tickerPriceModel ->
                Log.i("APP", "Ticker price model observed: $tickerPriceModel")
                val ticker = chooseTicker.text.toString()
                chooseTicker.text = ticker + " | Latest Price: ${tickerPriceModel.latestPrice}"

            }
        )
    }

    fun onRadioButtonClicked(v: View){

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        // Check which request we're responding to
        if (requestCode == PICK_TICKER_REQUEST) {
            // Make sure the request was successful
            if (resultCode == Activity.RESULT_OK) {
                val ticker = data?.getStringExtra("ticker")
                chooseTicker.text = ticker
                companyName = data?.getStringExtra("companyName")
                viewModel.fetchTickerPrice(ticker!!)
             }
        }

        super.onActivityResult(requestCode, resultCode, data)
    }

    private fun showEditDialog() {
      val fm = supportFragmentManager
      val fragment = PickIdeaDurationFragment.newInstance("Pick Idea Duration", "s");

        fragment.show(fm, "fragment_pick_idea_duration");
  }

    override fun onFragmentInteraction(uri: Uri) {
       println("callback from dialog fragment")//To change body of created functions use File | Settings | File Templates.
    }

}
