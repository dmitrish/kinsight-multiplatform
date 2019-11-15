package com.kinsight.kinsightmultiplatform.views

import android.os.Bundle
import android.util.Log
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.kinsight.kinsightmultiplatform.R
import com.kinsight.kinsightmultiplatform.ViewModels.IdeaCreateViewModel
import com.kinsight.kinsightmultiplatform.extensions.getViewModel
import com.kinsight.kinsightmultiplatform.models.TickerModel
import kotlinx.android.synthetic.main.activity_idea_create.*
import android.graphics.Color
import android.widget.*
import com.kinsight.kinsightmultiplatform.ViewModels.TickerSearchModel


class IdeaCreateActivity : FullScreenActivity(), OnTickerClickListener {

    private lateinit var adapter: TickerRecyclerAdapter
    private lateinit var linearLayoutManager: LinearLayoutManager
    private var currentSearchText: String =""

    private val viewModel: IdeaCreateViewModel by lazy {
        getViewModel { IdeaCreateViewModel() }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_idea_create)

        search.setOnQueryTextListener(object : SearchView.OnQueryTextListener {

            override fun onQueryTextChange(newText: String): Boolean {
                currentSearchText = newText
                println("filter text: $newText")
                if (!newText.isNullOrEmpty()) viewModel.loadTickers(newText)
                return false
            }

            override fun onQueryTextSubmit(query: String): Boolean {
                // task HERE
                return false
            }

        })

       /* viewModel.getTickers().observe(
            this,
            Observer<List<TickerModel>> { tickers ->
                Log.i("APP", "Tickers observed: $tickers")
                if (currentSearchText == viewModel.lastFilter) {
                    adapter = TickerRecyclerAdapter(tickers, this)
                    tickersRecyclerView.adapter = adapter
                }
            }
        )

        */

        viewModel.getTickerSearchModel().observe(
            this,
            Observer<TickerSearchModel> { model ->
                Log.i("APP", "Tickers observed: $model")
                if (currentSearchText == model.searchFilter) {
                    adapter = TickerRecyclerAdapter(model.tickers, this)
                    tickersRecyclerView.adapter = adapter
                }
            }
        )


        val id = search.getContext().getResources().getIdentifier(
            "android:id/search_src_text",
            null, null
        )

        val iconid = search.getContext().getResources().getIdentifier(
            "android:id/search_button",
            null, null
        )
        val searchIcon = search.findViewById<ImageView>(iconid)

        searchIcon.setColorFilter(
            Color.WHITE,
            android.graphics.PorterDuff.Mode.SRC_IN
        )

        val textView = search.findViewById(id) as TextView
        textView.setTextColor(Color.WHITE)
        textView.setHintTextColor(Color.WHITE)
    }


    override fun onItemClicked(ticker: TickerModel) {
        Toast.makeText(this,"Ticker ${ticker.symbol} ", Toast.LENGTH_LONG)
            .show()
        Log.i("IDEA_", ticker.symbol)

    }

    private fun initRecyclerView() {
        linearLayoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        tickersRecyclerView.layoutManager = linearLayoutManager
    }
}
