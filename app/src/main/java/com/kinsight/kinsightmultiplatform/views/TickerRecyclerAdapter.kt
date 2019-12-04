package com.kinsight.kinsightmultiplatform.views

import android.util.Log
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.kinsight.kinsightmultiplatform.R
import com.kinsight.kinsightmultiplatform.extensions.inflate
import com.kinsight.kinsightmultiplatform.models.TickerModel
import kotlinx.android.synthetic.main.ticker_item.view.*

class TickerRecyclerAdapter (private val tickers: List<TickerModel>, val itemClickListener: OnTickerClickListener) :
    RecyclerView.Adapter<TickerRecyclerAdapter.TickerHolder>()  {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int):
            TickerRecyclerAdapter.TickerHolder {
        val inflatedView = parent.inflate(R.layout.ticker_item, false)
        return TickerHolder(inflatedView)
    }

    override fun getItemCount(): Int = tickers.size

    override fun onBindViewHolder(holder: TickerRecyclerAdapter.TickerHolder, position: Int) {
        val item = tickers[position]
        holder.bindTicker(item, itemClickListener)
    }

    class TickerHolder(v: View) : RecyclerView.ViewHolder(v), View.OnClickListener {
        private var view: View = v
        private var ticker: TickerModel? = null

        init {
            v.setOnClickListener(this)
        }

        override fun onClick(v: View) {
            Log.d("Tickers RecyclerView", "Ticker Clicked")
        }

        fun bindTicker(ticker: TickerModel, clickListener: OnTickerClickListener) {
            this.ticker = ticker
            view.tickerSymbol.text =ticker.symbol + " (" + ticker.exchange + ")"
            view.tickerName.text = ticker.name
           // view.exchangeName.text = ticker.exchange

            itemView.setOnClickListener {
                clickListener.onItemClicked(ticker)
            }
        }

        companion object {
            private val IDEA_KEY = "TICKER"
        }
    }
}

interface OnTickerClickListener {
    fun onItemClicked(ticker: TickerModel)
}