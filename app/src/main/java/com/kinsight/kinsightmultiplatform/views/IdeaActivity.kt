package com.kinsight.kinsightmultiplatform.views

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.kinsight.kinsightmultiplatform.R
import kotlinx.android.synthetic.main.activity_idea.*
import kotlinx.android.synthetic.main.idea_item.*
import kotlinx.android.synthetic.main.idea_item.view.*

class IdeaActivity : FullScreenActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_idea)

        val startIntent = intent
        val companyName = startIntent.getStringExtra("ideaCompanyName")
        val alpha = startIntent.getStringExtra("ideaAlpha")

        ideaCompany.text = companyName
        alphaValue.text = alpha

        if (alpha.toDouble()> 4){
            alphaLabl.setImageResource(R.drawable.ic_fish_superhot)
        }
        if (alpha.toDouble() > 3 && alpha.toDouble() < 4){
            alphaLabl.setImageResource(R.drawable.ic_fish_blue)
        }
        if (alpha.toDouble() < 1){
            alphaLabl.setImageResource(R.drawable.ic_fish_onfire)
        }


    }
}
