package com.kinsight.kinsightmultiplatform

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView
import com.kinsight.kinsightmultiplatform.api.IdeaApi
import com.kinsight.kinsightmultiplatform.repository.IdeaRepository
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        findViewById<TextView>(R.id.main_text).text = createApplicationScreenMessage()

        var ideaRep = IdeaRepository()

        lifecycleScope.launch {
            val result = ideaRep.fetchIdeas();
            print(result)
        }

        //var data = ideaRep.fetchIdeas()
    }
}
