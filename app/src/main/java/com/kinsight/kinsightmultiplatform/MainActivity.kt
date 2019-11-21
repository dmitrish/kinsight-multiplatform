package com.kinsight.kinsightmultiplatform

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.core.view.isVisible
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.kinsight.kinsightmultiplatform.ViewModels.IdeasViewModel
import com.kinsight.kinsightmultiplatform.extensions.getViewModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.notifications.NotificationHelper
import com.kinsight.kinsightmultiplatform.views.*
import kotlinx.android.synthetic.main.customprogress.*
import kotlinx.android.synthetic.main.ideas_layout.*
import kotlinx.android.synthetic.main.loading.*


class MainActivity : FullScreenActivity(), OnItemClickListener {

    private lateinit var adapter: RecyclerAdapter
    private lateinit var linearLayoutManager: LinearLayoutManager
    private val viewModel: IdeasViewModel by lazy {
        getViewModel { IdeasViewModel(application, "dmitri") }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.ideas_layout)
        initRecyclerView()
        initViewModelListener()
        NotificationHelper.createNotificationChannel(this, 1, true, "channel", "channel")

        fab.setOnClickListener {
            startIdeaCreateActivity()
        }
    }

    override fun onResume() {
        super.onResume()
        swiperefresh.setOnRefreshListener {
            loading.isVisible = true
            initViewModelListener()
        }
    }

    override fun onItemClicked(idea: IdeaModel) {
        Log.i("IDEA_", idea.securityName)
        startIdeaDetailActivity(idea)
    }

    private fun startIdeaDetailActivity(idea: IdeaModel) {
        val intent = Intent(this, IdeaActivity::class.java)
        intent.putExtra("ideaCompanyName", idea.securityName)
        intent.putExtra("ideaTicker", idea.securityTicker)
        intent.putExtra("ideaAlpha", idea.alpha)
        intent.putExtra("ideaTargetPrice", idea.targetPrice)
        intent.putExtra("ideaCreatedBy", idea.createdBy)
        startActivity(intent)
    }

    private fun startIdeaCreateActivity() {
        val intent = Intent(this, IdeaCreateActivity::class.java)
        intent.putExtra("nextId", viewModel.nextId() + 2)
        startActivity(intent)
    }

    private fun initViewModelListener() {
        viewModel.getIdeas().observe(
            this,
            Observer<List<IdeaModel>> { ideas ->
                Log.i("APP", "Ideas observed: $ideas")
                adapter = RecyclerAdapter(ideas, this)
                ideasRecyclerView.adapter = adapter
                swiperefresh.isRefreshing = false
                loading.isVisible = false
            }
        )
    }

    private fun initRecyclerView() {
        linearLayoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        ideasRecyclerView.layoutManager = linearLayoutManager
    }
}
