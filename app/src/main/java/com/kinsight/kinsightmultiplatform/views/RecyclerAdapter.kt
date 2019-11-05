package com.kinsight.kinsightmultiplatform.views

import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import androidx.recyclerview.widget.RecyclerView
import com.kinsight.kinsightmultiplatform.R
import com.kinsight.kinsightmultiplatform.extensions.inflate
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import kotlinx.android.synthetic.main.idea_item.view.*

class RecyclerAdapter (private val ideas: List<IdeaModel>, val itemClickListener: OnItemClickListener) :
    RecyclerView.Adapter<RecyclerAdapter.IdeaHolder>()  {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int):
            RecyclerAdapter.IdeaHolder {
        val inflatedView = parent.inflate(R.layout.idea_item, false)
        return IdeaHolder(inflatedView)
    }

    override fun getItemCount(): Int = ideas.size

    override fun onBindViewHolder(holder: RecyclerAdapter.IdeaHolder, position: Int) {
        val itemIdea = ideas[position]
        holder.bindIdea(itemIdea, itemClickListener)
    }

    class IdeaHolder(v: View) : RecyclerView.ViewHolder(v), View.OnClickListener {
        private var view: View = v
        private var idea: IdeaModel? = null

        init {
            v.setOnClickListener(this)
        }

        override fun onClick(v: View) {
            Log.d("Ideas RecyclerView", "Idea Clicked")
        }

        fun bindIdea(idea: IdeaModel, clickListener: OnItemClickListener) {
            this.idea = idea
            view.nameText.text = idea.securityName
            view.ideaAlpha.text = "Alpha: ${idea.alpha}"
            view.ideaTargetPrice.text = "Target: ${idea.targetPrice} ${idea.stockCurrency}"

            itemView.setOnClickListener {
                clickListener.onItemClicked(idea)
            }
        }

        companion object {
            private val IDEA_KEY = "IDEA"
        }
    }
}

interface OnItemClickListener{
    fun onItemClicked(idea: IdeaModel)
}