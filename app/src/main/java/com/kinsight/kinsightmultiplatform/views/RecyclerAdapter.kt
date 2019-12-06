package com.kinsight.kinsightmultiplatform.views

import android.graphics.Color
import android.util.Log
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.kinsight.kinsightmultiplatform.R
import com.kinsight.kinsightmultiplatform.extensions.inflate
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import kotlinx.android.synthetic.main.idea_item.view.*
import java.math.RoundingMode
import java.text.DecimalFormat

class RecyclerAdapter (private val ideas: List<IdeaModel>, val itemClickListener: OnItemClickListener) :
    RecyclerView.Adapter<RecyclerAdapter.IdeaHolder>()  {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int):
           IdeaHolder {
        val inflatedView = parent.inflate(R.layout.idea_item, false)
        return IdeaHolder(inflatedView)
    }

    override fun getItemCount(): Int = ideas.size

    override fun onBindViewHolder(holder: IdeaHolder, position: Int) {
        val itemIdea = ideas[position]
        holder.bindIdea(itemIdea, itemClickListener)
    }

    inner class IdeaHolder(v: View) : RecyclerView.ViewHolder(v), View.OnClickListener {
        private var view: View = v
        private var idea: IdeaModel? = null

        init {
            v.setOnClickListener(this)
        }

        override fun onClick(v: View) {
            itemClickListener.onItemClicked(idea!!, view)
            Log.d("Ideas RecyclerView", "Idea Clicked")
        }

        fun bindIdea(idea: IdeaModel, clickListener: OnItemClickListener) {

            this.idea = idea

            itemView.setOnClickListener {
                clickListener.onItemClicked(idea, view)
            }

            setViewValues(idea)

            setViewImages(idea)

            animateView(idea)
        }

        private fun setViewImages(idea: IdeaModel) {
            val fishImageResource = getFishImageForAlpha(idea.alpha)
            view.ideaImage2.setImageResource(fishImageResource)
        }

        private fun setViewValues(idea: IdeaModel) {
            val alpha = getRoundedValue(idea.alpha)
            val psi = getRoundedValue(idea.benchMarkPerformance)

            view.nameText.text = idea.securityTicker

            view.ideaAlpha.text = alpha
            view.ideaSecurityName.text = idea.securityName

            view.ideaCreatedBy.text = "By: ${idea.createdBy}"
            view.ideaPsi.text = "φ  " + psi.drop(0)
        }


        private fun animateView(idea: IdeaModel){

            if (idea.currentPrice == idea.previousCurrentPrice) {
                return
            }

            animateAlpha(idea)
        }

        private fun animateAlpha(idea: IdeaModel) {
            val alphaColor = getColorForAlphaValue(idea)

            view.ideaAlpha.alpha = 0.5f
            view.ideaAlpha.setTextColor(alphaColor)
            view.ideaAlpha.visibility = View.VISIBLE
            view.ideaAlpha.animate().apply {
                duration = 2000
                alpha(1f)
                start()
            }

            view.ideaAlpha.postDelayed({ view.ideaAlpha.setTextColor(Color.WHITE) }, 2000)
        }

    }

    companion object {
         private val df = DecimalFormat("#0.00").apply {
             roundingMode = RoundingMode.CEILING
         }

         fun getRoundedValue (value: Double): String {
             return df.format(value)
         }

         fun getColorForAlphaValue (idea: IdeaModel) : Int {
             var alphaColor = Color.WHITE

             if (idea.currentPrice > idea.previousCurrentPrice ){
                 alphaColor =  Color.GREEN
             }
             else if (idea.currentPrice > idea.previousCurrentPrice){
                 alphaColor = Color.RED
             }

             return alphaColor
         }

        fun getFishImageForAlpha(alpha: Double) : Int {
            return when {
                alpha >= 4 -> R.drawable.ic_fish_green
                alpha >= 3 -> R.drawable.ic_fish_yellow
                alpha >= 1 -> R.drawable.ic_fish_pale_yellow
                alpha < 1 -> R.drawable.ic_fish_superhot
                else -> R.drawable.ic_fish_blue
            }
        }
    }
}

interface OnItemClickListener{
    fun onItemClicked(idea: IdeaModel, view: View)
}