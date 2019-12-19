package com.spb.spb.kinsightmultiplatformwearos

import android.os.Bundle
import android.support.wearable.activity.WearableActivity
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LifecycleRegistry


open class WearableActivityLifecycleOwning : WearableActivity(), LifecycleOwner {
    private var mLifecycleRegistry: LifecycleRegistry? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mLifecycleRegistry = LifecycleRegistry(this)
        mLifecycleRegistry!!.markState(Lifecycle.State.CREATED)
    }

    public override fun onStart() {
        super.onStart()
        mLifecycleRegistry!!.markState(Lifecycle.State.STARTED)
    }

    override fun getLifecycle(): Lifecycle {
        return mLifecycleRegistry!!
    }
}