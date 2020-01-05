package com.kinsight.kinsightmultiplatform.kinsightmultiplatformjetpackcomposeui

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.*
import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer
import androidx.ui.core.Text
import androidx.ui.core.dp
import androidx.ui.core.setContent
import androidx.ui.layout.Column
import androidx.ui.layout.Padding
import androidx.ui.material.MaterialTheme
import androidx.ui.tooling.preview.Preview
import com.kinsight.kinsightmultiplatform.models.IdeaModel

class IdeasActivity : AppCompatActivity() {
    private val viewModel: IdeasViewModel by lazy {
         IdeasViewModel() 
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
             //  mainLayout(ideasViewModel = viewModel)
            }
        }
    }
}
