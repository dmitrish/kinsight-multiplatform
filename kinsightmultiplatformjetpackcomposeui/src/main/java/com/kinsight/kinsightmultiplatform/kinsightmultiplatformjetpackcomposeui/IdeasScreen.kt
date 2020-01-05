package com.kinsight.kinsightmultiplatform.kinsightmultiplatformjetpackcomposeui

import androidx.compose.*
import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer
import androidx.ui.core.Alignment
import androidx.ui.core.Clip
import androidx.ui.core.Text
import androidx.ui.core.dp
import androidx.ui.foundation.DrawImage
import androidx.ui.foundation.shape.corner.RoundedCornerShape
import androidx.ui.graphics.Color
import androidx.ui.layout.*
import androidx.ui.material.MaterialTheme
import androidx.ui.res.imageResource
import androidx.ui.text.TextStyle
import androidx.ui.tooling.preview.Preview
import com.kinsight.kinsightmultiplatform.IdeaModelLogicDecorator
import com.kinsight.kinsightmultiplatform.models.IdeaModel

@Composable
fun ideasScreen() {
    val ideasViewModel = IdeasViewModel()

    val image = +imageResource(R.drawable.screenbg)
    DrawImage(image = image)

    MaterialTheme {
        val ideas = +observe(ideasViewModel.ideas)
        Column {
            ideas?.forEach { idea ->
                HeaderRow(idea)
                BodyRow(idea)
                BodyRow2(idea)
            }
        }
    }
}

fun getFishImageForAlpha(alpha: Double) : Int {
    return when {
        alpha >= 4 -> R.drawable.ic_fish_green
        alpha >= 3 -> R.drawable.ic_fish_yellow

        else -> R.drawable.ic_fish_green
    }
}

@Composable
fun BodyRow(idea: IdeaModel) {
    val ideDecor = IdeaModelLogicDecorator(idea)
    Padding(EdgeInsets(16.dp, 2.dp, 16.dp, 0.dp)) {
        FlexRow() {
             expanded(1f) {
                 Text(
                     text = "${idea.securityName}",
                     style = TextStyle(color = Color.White)
                 )

             }
            inflexible {
                Container(
                    modifier = Height(33.dp), padding = EdgeInsets(0.dp, 3.dp, 0.dp, 0.dp)
                ) {
                    Clip(shape = RoundedCornerShape(30.dp)) {
                        VectorImage(id = getFishImageForAlpha(idea.alpha))
                    }
                }
                Text(
                    text = "${ideDecor.getDisplayValueForAlpha()}",
                    style = TextStyle(color = Color.White)
                )
            }

        }
    }
}

@Composable
fun BodyRow2(idea: IdeaModel) {
    val ideDecor = IdeaModelLogicDecorator(idea)
    Padding(EdgeInsets(16.dp, -10.dp, 16.dp, 0.dp)) {
        FlexRow() {
            expanded(1f) {
                Text(
                    text = "By ${idea.createdBy}",
                    style = TextStyle(color = Color.White)
                )

            }
            inflexible {
                Container(
                    modifier = Height(33.dp), padding = EdgeInsets(0.dp, 3.dp, 0.dp, 0.dp)
                ) {
                    Clip(shape = RoundedCornerShape(30.dp)) {
                        VectorImage(id = getFishImageForAlpha(idea.alpha))
                    }
                }
                Text(
                    text = "${ideDecor.getDisplayValueForAlpha()}",
                    style = TextStyle(color = Color.White)
                )
            }

        }
    }
}
@Composable
fun HeaderRow(idea: IdeaModel) {
    Padding(EdgeInsets(16.dp, 5.dp, 0.dp, 0.dp)) {
        Text(text = "${idea.securityTicker}",
            style = TextStyle(color = Color.White) )
    }
}



fun <T> observe(data: LiveData<T>) = effectOf<T?> {
    val result = +state<T?> { data.value }
    val observer = +memo { Observer<T> { result.value = it } }

    +onCommit(data) {
        data.observeForever(observer)
        onDispose { data.removeObserver(observer) }
    }

    result.value
}

@Preview
@Composable
fun DefaultPreview2() {
    MaterialTheme {
        ideasScreen()
    }
}
