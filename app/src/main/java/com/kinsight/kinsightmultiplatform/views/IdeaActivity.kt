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

        if (alpha >= 4){
            alphaLabl.setImageResource(R.drawable.ic_fish_superhot)
       }
        else if (alpha >= 3 && alpha < 4){
            alphaLabl.setImageResource(R.drawable.ic_fish_green)
        }
        else if (alpha >= 1 && alpha < 3){
            alphaLabl.setImageResource(R.drawable.ic_fish_pale_yellow)
        }
        if (alpha < 1){
            alphaLabl.setImageResource(R.drawable.ic_fish_yellow)
        }



       /* val path = Path().apply {
            arcTo(0f, 0f, 1000f, 1000f, 270f, -180f, true)
        }
        val pathInterpolator = PathInterpolator(path)


        */
        alphaLabl.alpha = 0F
        alphaLabl.animate().apply {
            duration = 3000
            alpha(1f)
            start()
        }

       /* val animation = ObjectAnimator.ofFloat(alphaLabl, "translationX", 100f).apply {
            interpolator = pathInterpolator
            start()
        }

        */


    }
}
