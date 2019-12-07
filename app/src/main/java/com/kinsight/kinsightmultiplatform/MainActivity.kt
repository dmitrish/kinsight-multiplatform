package com.kinsight.kinsightmultiplatform

import android.content.Intent
import android.graphics.drawable.AnimationDrawable
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.ImageView
import androidx.core.app.ActivityCompat
import androidx.core.app.ActivityOptionsCompat
import androidx.core.view.isVisible
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.kinsight.kinsightmultiplatform.ViewModels.IdeasViewModel
import com.kinsight.kinsightmultiplatform.extensions.getViewModel
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.notifications.NotificationHelper
import com.kinsight.kinsightmultiplatform.views.*
import kotlinx.android.synthetic.main.ideas_layout.*
import androidx.core.util.Pair

class MainActivity : FullScreenActivity(), OnItemClickListener {

    private lateinit var adapter: RecyclerAdapter
    private lateinit var linearLayoutManager: LinearLayoutManager
    private var notificationOnNewIdea: Int? = null
    private val viewModel: IdeasViewModel by lazy {
        getViewModel { IdeasViewModel(application, "dmitri") }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.ideas_layout)
        initRecyclerView()
        initViewModelListener()
        animate()
        NotificationHelper.createNotificationChannel(this, 1, true, "channel", "channel")

        fab.setOnClickListener {
            startIdeaCreateActivity()
        }

        notificationOnNewIdea = intent.getIntExtra("notificationExtra", 0)

    }

    override fun onResume() {
        super.onResume()
        swiperefresh.setOnRefreshListener {
            loading.isVisible = true
            initViewModelListener()
        }
    }

    var lastView: View? = null
    override fun onItemClicked(idea: IdeaModel, view: View) {
       // lastView = view
        Log.i("IDEA_", idea.securityName)
        startIdeaDetailActivity(idea, view)
    }

    private fun startIdeaDetailActivity(idea: IdeaModel, view: View) {

        val sharedImage = view.findViewById<ImageView>(R.id.ideaImage2)
        val imagePair = Pair.create(sharedImage as View, "tImage")
        val options = ActivityOptionsCompat.makeSceneTransitionAnimation(this@MainActivity, imagePair)
        val intent = Intent(this, IdeaActivity::class.java)
        intent.putExtra("IDEA", idea)
        ActivityCompat.startActivity(this@MainActivity, intent, options.toBundle())
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

                if (notificationOnNewIdea != 0){

                    //TODO - once idea id is passed from server, read from notification and pass that
                    val ideaModel = viewModel.getIdea(notificationOnNewIdea!!)
                    val intent = Intent(this, IdeaActivity::class.java)
                    intent.putExtra("IDEA", ideaModel)
                    notificationOnNewIdea = null
                    startActivity(intent)

                }
            }
        )
    }

    private fun initRecyclerView() {
        linearLayoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
        ideasRecyclerView.layoutManager = linearLayoutManager
    }

    private fun animate() {
        val animDrawable = rootConstraintLayout.background as AnimationDrawable
        animDrawable.setEnterFadeDuration(10)
        animDrawable.setExitFadeDuration(5000)
        animDrawable.start()
    }
}
