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
import android.view.ViewAnimationUtils
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.resources.Strings


class IdeaActivity : FullScreenActivity() {

     companion object Params {
        val INITIAL_SCALE = 1f
        val STIFFNESS = SpringForce.STIFFNESS_VERY_LOW
        val DAMPING_RATIO = SpringForce.DAMPING_RATIO_HIGH_BOUNCY
        const val IDEA_COMPANY_NAME = "IDEA_COMPANY_NAME"
        const val IDEA_TICKER = "IDEA_TICKER"
        const val IDEA_ALPHA = "IDEA_ALPHA"
        const val IDEA_CREATED_BY = "IDEA_CREATED_BY"
        const val IDEA_TARGET_PRICE = "IDEA_TARGET_PRICE"
        const val IDEA_CURRENT_PRICE = "IDEA_CURRENT_PRICE"
        const val IDEA_DIRECTION = "IDEA_DIRECTION"
        const val IDEA_HORIZON = "IDEA_HORIZON"
        const val IDEA_CONVICTION = "IDEA_CONVICTION"
        const val IDEA_CREATED_FROM = "IDEA_CREATED_FROM"
    }

    lateinit var scaleXAnimation: SpringAnimation
    lateinit var scaleYAnimation: SpringAnimation
    lateinit var scaleGestureDetector: ScaleGestureDetector
    lateinit var ideaModel: IdeaModel


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_idea)

        val startIntent = intent
        ideaModel = startIntent.getParcelableExtra<IdeaModel>("IDEA")!!

        println("idea unparceled: $ideaModel")

        val direction = startIntent.getStringExtra(IDEA_DIRECTION)
        val conviction = startIntent.getStringExtra(IDEA_CONVICTION)


        ideaCompany.text = ideaModel.securityName
        ideaTicker.text = ideaModel.securityTicker

        val df = DecimalFormat("00.00")
        df.roundingMode = RoundingMode.CEILING
        val alphaFormatted = df.format(ideaModel.alpha)
        alphaValue.text = alphaFormatted
        val targetFormatted = df.format(ideaModel.targetPrice)
        val currentFormatted = df.format(ideaModel.currentPrice)
        ideaDetailCurrentPrice.text ="$${currentFormatted}"
        ideaDetailTargetPrice.text ="$${targetFormatted}"

        ideaHorizon.text = ideaModel.timeHorizon
        ideaConviction.text = conviction

        val fishImageResource = getFishImageForAlpha(ideaModel.alpha)
        alphaLabl.setImageResource(fishImageResource)

        setFishermanImage(ideaModel.createdBy)

        setDirectionImage(direction)

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

    private fun setFishermanImage(createdBy: String) {
        val imageResource = getFishermanImageResourceForCreatedBy(createdBy)
        fishermanImage.setImageResource(imageResource)
        val fishermanName = getFishermanImageName(imageResource)
        fishermanText.text = fishermanName
    }

    private fun setDirectionImage(direction: String) {
        val imageResource = getDirectionImageResource(direction)
        directionImage.setImageResource(imageResource)
    }

    private fun getDirectionImageResource(direction: String) : Int{
        return when (direction){
            Strings.direction_long -> R.drawable.ic_bullmarket
            Strings.direction_short -> R.drawable.ic_bearmarket
            else -> R.drawable.ic_bearmarket
        }
    }


    private fun getFishermanImageResourceForCreatedBy(createdBy: String) : Int{
        return when (createdBy) {
            "Dmitri"  -> R.drawable.ic_man
            "Ajay" -> R.drawable.ic_ajay
            "Piyush"  -> R.drawable.ic_piyush
            "Mark"  -> R.drawable.ic_mark
            else -> R.drawable.ic_fish_blue
        }
    }

    private fun getFishermanImageName(resourceId: Int) : String{
        return when (resourceId) {
             R.drawable.ic_man  -> "Dmitri"
             R.drawable.ic_ajay -> "Ajay"
             R.drawable.ic_piyush -> "Piyush"
             R.drawable.ic_mark -> "Mark"
            else -> "Unknown"
        }
    }

    override fun onResume() {
        super.onResume()
        lifecycleScope.launch {
            delay(250)
            withContext(Dispatchers.Main) {
                alphaLabl.scaleX = 6.5f
                alphaLabl.scaleY = 6.5f
                scaleXAnimation.start()
                scaleYAnimation.start()
            }
            animateFisherman()
        }


    }

    private fun animateFisherman(){
        fishermanCard.alpha = 0f
        fishermanCard.visibility = View.VISIBLE
        fishermanImage.visibility = View.VISIBLE
        fishermanCard.animate().apply {
            duration = 2000
            alpha(1f)
            start()
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

    private fun createSpringAnimation(view: View,
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
    private fun circularRevealCard(view: View) {
        val finalRadius = Math.max(view.width, view.height).toFloat()

        // create the animator for this view (the start radius is zero)
        val circularReveal =
            ViewAnimationUtils.createCircularReveal(view, 0, 0, 0f, finalRadius * 1.1f)
        circularReveal.duration = 1000

        // make the view visible and start the animation
        view.visibility = View.VISIBLE

        circularReveal.start()
    }
}
