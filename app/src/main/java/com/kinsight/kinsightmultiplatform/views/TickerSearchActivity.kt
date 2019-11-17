package com.kinsight.kinsightmultiplatform.views

import android.os.Bundle
import android.util.Log
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.kinsight.kinsightmultiplatform.R
import com.kinsight.kinsightmultiplatform.ViewModels.TickerSearchViewModel
import com.kinsight.kinsightmultiplatform.extensions.getViewModel
import com.kinsight.kinsightmultiplatform.models.TickerModel
import kotlinx.android.synthetic.main.activity_ticker_search.*
import android.graphics.Color
import android.graphics.PorterDuff
import android.widget.*
import androidx.core.view.isVisible
import com.kinsight.kinsightmultiplatform.ViewModels.TickerSearchModel


class TickerSearchActivity : FullScreenActivity(), OnTickerClickListener {

    private lateinit var adapter: TickerRecyclerAdapter
    private lateinit var linearLayoutManager: LinearLayoutManager
    private var currentSearchText: String = ""

    private val viewModel: TickerSearchViewModel by lazy {
        getViewModel { TickerSearchViewModel() }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_ticker_search)

        setUpSearchBarListener()

        viewModel.getTickerSearchModel().observe(
            this,
            Observer<TickerSearchModel> { model ->
                Log.i("APP", "Tickers observed: $model")
                if (currentSearchText == model.searchFilter) {
                    adapter = TickerRecyclerAdapter(model.tickers, this)
                    tickersRecyclerView.adapter = adapter
                    tickersRecyclerView.isVisible = true
                }
                if (currentSearchText == ""){
                    tickersRecyclerView.isVisible = false
                }
            }
        )

        setSearchBarAppearance()

        tickersRecyclerView.isVisible = false
    }

    private fun setUpSearchBarListener() {
        search.setOnQueryTextListener(object : SearchView.OnQueryTextListener {

            override fun onQueryTextChange(newText: String): Boolean {
                currentSearchText = newText
                println("filter text: $newText")
                if (newText.isNotEmpty()) {
                    viewModel.loadTickers(newText)
                }
                else{
                    tickersRecyclerView.isVisible = false
                }
                return false
            }

            override fun onQueryTextSubmit(query: String): Boolean {
                return false
            }
        })
    }

    private fun setSearchBarAppearance() {
        val id = search.context.resources.getIdentifier(
            "android:id/search_src_text",
            null, null
        )

        val iconid = search.context.resources.getIdentifier(
            "android:id/search_button",
            null, null
        )
        val searchIcon = search.findViewById<ImageView>(iconid)

        searchIcon.setColorFilter(
            Color.WHITE,
            PorterDuff.Mode.SRC_IN
        )

        val textView = search.findViewById(id) as TextView
        textView.setTextColor(Color.WHITE)
        textView.setHintTextColor(Color.WHITE)
    }


    override fun onItemClicked(ticker: TickerModel) {
        Toast.makeText(this,"Ticker ${ticker.symbol} ", Toast.LENGTH_LONG)
            .show()
        Log.i("TICKER_", ticker.symbol)

        intent.putExtra("ticker", ticker.symbol)

        setResult(RESULT_OK, intent);

        finish();

    }

    private fun initRecyclerView() {
        linearLayoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        tickersRecyclerView.layoutManager = linearLayoutManager
    }
}
