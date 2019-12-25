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
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.wear.widget.WearableLinearLayoutManager
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Adapters.IdeasRecyclerAdapter
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Adapters.OnItemClickListener
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.IdeasViewModel
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Notifications.NotificationHelper
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Notifications.OnNotificationListener
import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.models.NotificationMessage
import kotlinx.android.synthetic.main.ideas_layout.*


class WearIdeasActivity : WearableActivityLifecycleOwning(), OnItemClickListener, OnNotificationListener, WearableRecyclerAdapter.ItemClickListener {

    //private lateinit var adapter: IdeasRecyclerAdapter
    private lateinit var wearableAdapter: WearableRecyclerAdapter
    private lateinit var linearLayoutManager: LinearLayoutManager

    private val viewModel: IdeasViewModel by lazy {
        IdeasViewModel(application, "dmitri", this as OnNotificationListener)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.ideas_layout)

        // Enables Always-on
        setAmbientEnabled()

       // initRecyclerView()

        initWearableRecyclerView()

        initViewModelListener()


        swiperefresh.rootView.requestFocus()

       // this.window.super

    }

    private fun initViewModelListener() {
        viewModel.getIdeas().observe(
            this,
            Observer<List<IdeaModel>> { ideas ->
                Log.i("APP", "Ideas observed: $ideas")
                wearableAdapter = WearableRecyclerAdapter(this, ideas)
                wearableAdapter.setClickListener(this)
              //  adapter = IdeasRecyclerAdapter(ideas, R.layout.idea_item, this)
                ideasRecyclerView.adapter = wearableAdapter
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

    private fun initWearableRecyclerView(){

        // Aligns the first and last items on the list vertically centered on the screen.
        ideasRecyclerView.setEdgeItemsCenteringEnabled(true)

        // Customizes scrolling so items farther away form center are smaller.
        // Customizes scrolling so items farther away form center are smaller.
        val scalingScrollLayoutCallback = ScalingScrollLayoutCallback()
        ideasRecyclerView.setLayoutManager(
            WearableLinearLayoutManager(this, scalingScrollLayoutCallback)
        )

        // Improves performance because we know changes in content do not change the layout size of
        // the RecyclerView.
        // Improves performance because we know changes in content do not change the layout size of
// the RecyclerView.
        ideasRecyclerView.setHasFixedSize(true)

       // ideasRecyclerView.setI

    }

    var lastView: View? = null
    override fun onItemClicked(idea: IdeaModel, view: View) {
        // lastView = view
        Log.i("IDEA_", idea.securityName)


        NotificationHelper.createNotificationChannel(this, 1, true, "channel", "channel")

        // startIdeaDetailActivity(idea, view)
        NotificationHelper.sendNotification(
            this,
            applicationContext,
            "Alpha Capture",
            "Mark created a new long idea on MSFT",
            "hello",
            false,
            11)
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

    override fun onNotification(notificationMessage: NotificationMessage) {
        NotificationHelper.sendNotification(
            this,
            applicationContext,
            "Alpha Capture",
            notificationMessage.message,
            notificationMessage.message,
            false,
            notificationMessage.ideaId )
    }

    override fun onItemClick(view: View?, position: Int) {
      val model = wearableAdapter.getItem(position)
      println("selected model: $model")
      startIdeaDetailActivity(model, view!!)
    }
}
