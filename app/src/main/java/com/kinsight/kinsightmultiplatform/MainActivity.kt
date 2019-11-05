package com.kinsight.kinsightmultiplatform

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.AdapterView
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import com.kinsight.kinsightmultiplatform.ViewModels.IdeaViewModelFactory
import com.kinsight.kinsightmultiplatform.ViewModels.IdeasViewModel
import com.kinsight.kinsightmultiplatform.extensions.getViewModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.views.FullScreenActivity
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

        val intent = Intent(this, IdeaDetailActivity::class.java)
        intent.putExtra("idea", idea.securityName)
        startActivity(intent)

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.ideas_layout)
        initRecyclerView()
        initViewModelListener()
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
