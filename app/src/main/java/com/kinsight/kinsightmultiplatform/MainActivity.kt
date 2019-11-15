package com.kinsight.kinsightmultiplatform

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.android.material.snackbar.Snackbar
import com.kinsight.kinsightmultiplatform.ViewModels.IdeasViewModel
import com.kinsight.kinsightmultiplatform.extensions.getViewModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.notifications.NotificationHelper
import com.kinsight.kinsightmultiplatform.views.FullScreenActivity
import com.kinsight.kinsightmultiplatform.views.IdeaCreateActivity
import com.kinsight.kinsightmultiplatform.views.OnItemClickListener
import com.kinsight.kinsightmultiplatform.views.RecyclerAdapter
import kotlinx.android.synthetic.main.ideas_layout.*


class MainActivity : FullScreenActivity(), OnItemClickListener {

    private lateinit var adapter: RecyclerAdapter
    private lateinit var linearLayoutManager: LinearLayoutManager
    private val viewModel: IdeasViewModel by lazy {
        getViewModel { IdeasViewModel(application, "dmitri") }
       // ViewModelProvider(this).get(IdeasViewModel::class.java)
        //ViewModelProviders.of(this, IdeaViewModelFactory(application, "s"))
    }

    override fun onItemClicked(idea: IdeaModel) {
        Toast.makeText(this,"Idea ${idea.securityName} \n Alpha: ${idea.alpha}", Toast.LENGTH_LONG)
            .show()
        Log.i("IDEA_", idea.securityName)



        NotificationHelper.sendNotification(this, "${idea.securityName} Idea Alert", "Price objective of ${idea.targetPrice} ${idea.stockCurrency} achieved", "Price objective of ${idea.targetPrice} ${idea.stockCurrency} achieved", false)

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.ideas_layout)
        initRecyclerView()
        initViewModelListener()
        NotificationHelper.createNotificationChannel(this, 1, true, "channel", "channel")


        fab.setOnClickListener { view ->
            val intent = Intent(this, IdeaCreateActivity::class.java)
            startActivity(intent)
        }
    }

    private fun initViewModelListener() {
        viewModel.getIdeas().observe(
            this,
            Observer<List<IdeaModel>> { ideas ->
                Log.i("APP", "Ideas observed: $ideas")
                adapter = RecyclerAdapter(ideas, this)
                ideasRecyclerView.adapter = adapter
            }
        )
    }

    private fun initRecyclerView() {
        linearLayoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        ideasRecyclerView.layoutManager = linearLayoutManager
    }
}
