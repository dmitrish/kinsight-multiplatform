package com.spb.spb.kinsightmultiplatformwearos

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import androidx.wear.widget.WearableLinearLayoutManager.LayoutCallback
import androidx.wear.widget.WearableRecyclerView


/**
 * Shrinks items (children) farther away from the center in a [WearableRecyclerView]. The UX
 * makes scrolling more readable.
 */
class ScalingScrollLayoutCallback : LayoutCallback() {
    private var mProgressToCenter = 0f
    /*
     * Scales the item's icons and text the farther away they are from center allowing the main
     * item to be more readable to the user on small devices like Wear.
     */
    override fun onLayoutFinished(
        child: View,
        parent: RecyclerView
    ) { // Figure out % progress from top to bottom.
        val centerOffset =
            child.height.toFloat() / 2.0f / parent.height.toFloat()
        val yRelativeToCenterOffset =
            child.y / parent.height + centerOffset
        // Normalizes for center.
        mProgressToCenter = Math.abs(0.5f - yRelativeToCenterOffset)
        // Adjusts to the maximum scale.
        mProgressToCenter = Math.min(
            mProgressToCenter,
            ScalingScrollLayoutCallback.Companion.MAX_CHILD_SCALE
        )
        child.scaleX = 1 - mProgressToCenter
        child.scaleY = 1 - mProgressToCenter
    }

    companion object {
        // Max we scale the child View.
        private const val MAX_CHILD_SCALE = 0.65f
    }
}
