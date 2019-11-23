package com.kinsight.kinsightmultiplatform.views

import android.os.Bundle
import android.view.MotionEvent
import android.view.ScaleGestureDetector
import android.view.View
import androidx.dynamicanimation.animation.DynamicAnimation
import androidx.dynamicanimation.animation.SpringAnimation
import androidx.dynamicanimation.animation.SpringForce
import androidx.lifecycle.lifecycleScope
import com.kinsight.kinsightmultiplatform.R
import kotlinx.android.synthetic.main.activity_idea.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.math.RoundingMode
import java.text.DecimalFormat



class IdeaActivity : FullScreenActivity() {

    private companion object Params {
        val INITIAL_SCALE = 1f
        val STIFFNESS = SpringForce.STIFFNESS_VERY_LOW
        val DAMPING_RATIO = SpringForce.DAMPING_RATIO_HIGH_BOUNCY
    }

    lateinit var scaleXAnimation: SpringAnimation
    lateinit var scaleYAnimation: SpringAnimation
    lateinit var scaleGestureDetector: ScaleGestureDetector


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

       // animateFish()

        // create scaleX and scaleY animations
        scaleXAnimation = createSpringAnimation(
            alphaLabl, SpringAnimation.SCALE_X,
            INITIAL_SCALE, STIFFNESS, DAMPING_RATIO)
        scaleYAnimation = createSpringAnimation(
            alphaLabl, SpringAnimation.SCALE_Y,
            INITIAL_SCALE, STIFFNESS, DAMPING_RATIO)

        setupPinchToZoom()

        alphaLabl.setOnTouchListener { _, event ->
            if (event.action == MotionEvent.ACTION_UP) {
                scaleXAnimation.start()
                scaleYAnimation.start()
            } else {
                // cancel animations so we can grab the view during previous animation
                scaleXAnimation.cancel()
                scaleYAnimation.cancel()

                // pass touch event to ScaleGestureDetector
                scaleGestureDetector.onTouchEvent(event)
            }
            true
        }


    }

    override fun onResume() {
        super.onResume()
        lifecycleScope.launch {
            delay(1000)
            withContext(Dispatchers.Main) {
                alphaLabl.scaleX = 6.5f
                alphaLabl.scaleY = 6.5f
                scaleXAnimation.start()
                scaleYAnimation.start()
            }
        }
    }

    private fun animateFish() {
        alphaLabl.alpha = 0F
        alphaLabl.y = 3500f
        alphaLabl.x = 1000f
        alphaLabl.scaleY = -2f
        alphaLabl.scaleX = -2f
        alphaLabl.animate().apply {
            duration = 2000
            x(164f)
            y(730f)
            alpha(1f)
            start()
        }
       /* alphaLabl.animate().apply {
            duration = 2000
            scaleX(1.2f)
            scaleY(1.2f)
            start()
        }*/

/*

        SpringAnimation(alphaLabl, DynamicAnimation.TRANSLATION_Y, 0f).apply {
            start()
        }

 */

    }

    private fun setupPinchToZoom() {
        var scaleFactor = 1f
        scaleGestureDetector = ScaleGestureDetector(this,
            object : ScaleGestureDetector.SimpleOnScaleGestureListener() {
                override fun onScale(detector: ScaleGestureDetector): Boolean {
                    scaleFactor *= detector.scaleFactor
                    alphaLabl.scaleX *= scaleFactor
                    alphaLabl.scaleY *= scaleFactor
                    return true
                }
            })
    }

    fun createSpringAnimation(view: View,
                              property: DynamicAnimation.ViewProperty,
                              finalPosition: Float,
                              stiffness: Float,
                              dampingRatio: Float): SpringAnimation {
        val animation = SpringAnimation(view, property)
        val spring = SpringForce(finalPosition)
        spring.stiffness = stiffness
        spring.dampingRatio = dampingRatio
        animation.spring = spring
        return animation
    }
}
