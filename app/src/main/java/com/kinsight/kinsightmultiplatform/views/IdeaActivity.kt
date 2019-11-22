package com.kinsight.kinsightmultiplatform.views

import android.os.Bundle
import com.kinsight.kinsightmultiplatform.R
import kotlinx.android.synthetic.main.activity_idea.*
import java.math.RoundingMode
import java.text.DecimalFormat



class IdeaActivity : FullScreenActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_idea)

        val startIntent = intent
        val companyName = startIntent.getStringExtra("ideaCompanyName")
        val ticker = startIntent.getStringExtra("ideaTicker")
        val alpha = startIntent.getDoubleExtra("ideaAlpha", 0.0)
        val createdBy = startIntent.getStringExtra("ideaCreatedBy")
        val targetPrice = startIntent.getDoubleExtra("ideaTargetPrice", 0.0)

        ideaCompany.text = companyName
        ideaTicker.text = ticker

        val df = DecimalFormat("00.00")
        df.roundingMode = RoundingMode.CEILING
        val alphaFormatted = df.format(alpha)
        alphaValue.text = alphaFormatted
        val targetFormatted = df.format(targetPrice)
        ideaDetailCurrentPrice.text ="$${targetFormatted}"
        ideaDetailTargetPrice.text ="$${targetFormatted}"

        val fishImageResource = getFishImageForAlpha(alpha)
        alphaLabl.setImageResource(fishImageResource)

        animateFish()
    }

    private fun animateFish() {
        alphaLabl.alpha = 0F
        alphaLabl.y = 3500f
        alphaLabl.x = 1000f
        alphaLabl.scaleY = -2f
        alphaLabl.scaleX = -2f
        alphaLabl.animate().apply {
            duration = 3000
            x(164f)
            y(730f)
            alpha(1f)
            start()
        }
        alphaLabl.animate().apply {
            duration = 2000
            scaleX(1.2f)
            scaleY(1.2f)
            start()
        }

    }
}
