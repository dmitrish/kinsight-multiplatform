package com.spb.spb.kinsightmultiplatformwearos

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.wearable.activity.WearableActivity
import android.view.MotionEvent
import android.view.ScaleGestureDetector
import android.view.View
import androidx.dynamicanimation.animation.DynamicAnimation
import androidx.dynamicanimation.animation.SpringAnimation
import androidx.dynamicanimation.animation.SpringForce
import com.kinsight.kinsightmultiplatform.IdeaModelLogicDecorator
import com.kinsight.kinsightmultiplatform.PriceKind
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Adapters.IdeasRecyclerAdapter.Companion.getFishImageForAlpha
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.spb.spb.kinsightmultiplatformwearos.WearIdeaDetailActivity.Params.DAMPING_RATIO
import com.spb.spb.kinsightmultiplatformwearos.WearIdeaDetailActivity.Params.INITIAL_SCALE
import com.spb.spb.kinsightmultiplatformwearos.WearIdeaDetailActivity.Params.STIFFNESS
import kotlinx.android.synthetic.main.activity_idea.*
import kotlinx.android.synthetic.main.activity_wear_idea_detail.*
import kotlinx.android.synthetic.main.activity_wear_idea_detail.alphaLabl
import kotlinx.android.synthetic.main.activity_wear_idea_detail.ideaConviction
import kotlinx.android.synthetic.main.activity_wear_idea_detail.ideaHorizon
import kotlinx.android.synthetic.main.activity_wear_idea_detail.ideaTicker
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext


class WearIdeaDetailActivity : WearableActivity() {

    companion object Params {
        val INITIAL_SCALE = 1f
        val STIFFNESS = SpringForce.STIFFNESS_VERY_LOW
        val DAMPING_RATIO = SpringForce.DAMPING_RATIO_HIGH_BOUNCY
    }

    lateinit var scaleXAnimation: SpringAnimation
    lateinit var scaleYAnimation: SpringAnimation
    lateinit var scaleGestureDetector: ScaleGestureDetector

    lateinit var ideaModel: IdeaModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_wear_idea_detail)

        // Enables Always-on
        setAmbientEnabled()

        ideaModel = intent.getParcelableExtra("IDEA")!!
        val ideaModelDecorator = IdeaModelLogicDecorator(ideaModel)

        println("idea unparceled: $ideaModel")

        //ideaCompany.text = ideaModel.securityName
        ideaTicker.text = ideaModel.securityTicker
       // alphaValue.text = ideaModelDecorator.getDisplayValueForAlpha() //alphaFormatted
     /*   ideaDetailCurrentPrice.text = ideaModelDecorator.getDisplayValueForPrice(priceKind = PriceKind.CURRENT)
        ideaDetailTargetPrice.text = ideaModelDecorator.getDisplayValueForPrice(priceKind = PriceKind.TARGET)
      */
        ideaCurrentPriceValue.text = ideaModelDecorator.getDisplayValueForPrice(priceKind = PriceKind.CURRENT)
        ideaTargetPriceValue.text =  ideaModelDecorator.getDisplayValueForPrice(priceKind = PriceKind.TARGET)
        ideaHorizon.text = ideaModel.timeHorizon
        ideaConviction.text = ideaModelDecorator.getConviction()

       setImagesAndAnimation()

        //closeIdea.alpha = 0.3f
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        val tasksManager: ActivityManager =
            getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        tasksManager.moveTaskToFront(taskId, ActivityManager.MOVE_TASK_NO_USER_ACTION)

    }

    override fun onResume() {
        super.onResume()
       // lifecycleScope.launch {
       //     delay(250)
       //     withContext(Dispatchers.Main) {
                alphaLabl.scaleX = 6.5f
                alphaLabl.scaleY = 6.5f
                scaleXAnimation.start()
                scaleYAnimation.start()
        //    }
           // animateFisherman()
      //  }
    }


    private fun setImagesAndAnimation() {
        val fishImageResource = getFishImageForAlpha(ideaModel.alpha)
        alphaLabl.setImageResource(fishImageResource)

      //  setFishermanImage(ideaModel.createdBy)

      //  setDirectionImage(ideaModel.direction)


        // create scaleX and scaleY animations
        scaleXAnimation = createSpringAnimation(
            alphaLabl, SpringAnimation.SCALE_X,
            INITIAL_SCALE, STIFFNESS, DAMPING_RATIO
        )
        scaleYAnimation = createSpringAnimation(
            alphaLabl, SpringAnimation.SCALE_Y,
            INITIAL_SCALE, STIFFNESS, DAMPING_RATIO
        )

      //  setupPinchToZoom()

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


    /*
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

     */

    /*private fun setupPinchToZoom() {
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
    }*/

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



}
