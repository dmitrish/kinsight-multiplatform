package com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Adapters

import android.graphics.Color
import android.util.Log
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.R
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Extensions.inflate
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import kotlinx.android.synthetic.main.idea_item.view.*

import java.math.RoundingMode
import java.text.DecimalFormat

class IdeasRecyclerAdapter (private val ideas: List<IdeaModel>, val resource: Int, val itemClickListener: OnItemClickListener) :
    RecyclerView.Adapter<IdeasRecyclerAdapter.IdeaHolder>()  {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int):
            IdeaHolder {
        val inflatedView = parent.inflate(resource, false)
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

            view.nameText.text = idea.securityName

            view.ideaAlpha.text = if(idea.alpha >0) alpha else " " + alpha.substring(0, alpha.length-1  )
            view.ideaSecurityName.text = idea.securityTicker

            view.ideaCreatedBy.text = "By: ${idea.createdBy}"
            view.ideaPsi.text = if (idea.benchMarkPerformance >0) "φ   " + psi.drop(0) else "φ  " + psi.drop(0)
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
            else if (idea.currentPrice < idea.previousCurrentPrice){
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