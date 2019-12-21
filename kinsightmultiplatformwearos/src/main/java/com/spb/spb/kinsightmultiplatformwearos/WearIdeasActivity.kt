package com.spb.spb.kinsightmultiplatformwearos

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.ImageView
import androidx.core.app.ActivityCompat
import androidx.core.app.ActivityOptionsCompat
import androidx.core.util.Pair
import androidx.core.view.isVisible
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Adapters.IdeasRecyclerAdapter
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Adapters.OnItemClickListener
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.IdeasViewModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import kotlinx.android.synthetic.main.ideas_layout.*


class WearIdeasActivity : WearableActivityLifecycleOwning(), OnItemClickListener {

    private lateinit var adapter: IdeasRecyclerAdapter
    private lateinit var linearLayoutManager: LinearLayoutManager

    private val viewModel: IdeasViewModel by lazy {
        IdeasViewModel(application, "dmitri")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.ideas_layout)

        // Enables Always-on
        setAmbientEnabled()

        initRecyclerView()

        initViewModelListener()

        swiperefresh.rootView.requestFocus()

       // this.window.super

    }

    private fun initViewModelListener() {
        viewModel.getIdeas().observe(
            this,
            Observer<List<IdeaModel>> { ideas ->
                Log.i("APP", "Ideas observed: $ideas")
                adapter = IdeasRecyclerAdapter(ideas, R.layout.idea_item, this)
                ideasRecyclerView.adapter = adapter
                swiperefresh.isRefreshing = false
               // loading.isVisible = false
               // swiperefresh.rootView.requestFocus()


            }
        )
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        val tasksManager =
            getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        tasksManager.moveTaskToFront(taskId, ActivityManager.MOVE_TASK_NO_USER_ACTION)

    }

    private fun initRecyclerView() {
        linearLayoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        ideasRecyclerView.layoutManager = linearLayoutManager
    }

    var lastView: View? = null
    override fun onItemClicked(idea: IdeaModel, view: View) {
        // lastView = view
        Log.i("IDEA_", idea.securityName)
        startIdeaDetailActivity(idea, view)
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        println("focus changedd")
        super.onWindowFocusChanged(hasFocus)
    }

    private fun startDetail(){
        val intent = Intent(this, WearIdeaDetailActivity::class.java)
        startActivity(intent)
    }

    private fun startIdeaDetailActivity(idea: IdeaModel, view: View) {

        val sharedImage = view.findViewById<ImageView>(R.id.ideaImage2)
        val imagePair = Pair.create(sharedImage as View, "tImage")
        val options = ActivityOptionsCompat.makeSceneTransitionAnimation(this@WearIdeasActivity, imagePair)
        val intent = Intent(this, WearIdeaDetailActivity::class.java)
        intent.putExtra("IDEA", idea)
        ActivityCompat.startActivity(this@WearIdeasActivity, intent, options.toBundle())
    }
}
