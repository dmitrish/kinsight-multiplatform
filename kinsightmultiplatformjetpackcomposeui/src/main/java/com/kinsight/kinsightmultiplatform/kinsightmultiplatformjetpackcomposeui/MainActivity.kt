package com.kinsight.kinsightmultiplatform.kinsightmultiplatformjetpackcomposeui

import android.os.Bundle
import android.os.PersistableBundle
import android.view.View
import android.view.Window
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.Composable
import androidx.compose.unaryPlus
import androidx.ui.core.*
import androidx.ui.foundation.DrawImage
import androidx.ui.foundation.shape.corner.RoundedCornerShape
import androidx.ui.graphics.Color
import androidx.ui.graphics.vector.DrawVector
import androidx.ui.layout.*
import androidx.ui.material.Button
import androidx.ui.res.imageResource
import androidx.ui.res.vectorResource
import androidx.ui.text.TextStyle
import androidx.ui.text.font.FontStyle
import androidx.ui.text.font.FontWeight
import androidx.ui.tooling.preview.Preview


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            App()
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) hideSystemUI()
    }

    private fun hideSystemUI() {
        // Enables regular immersive mode.
        // For "lean back" mode, remove SYSTEM_UI_FLAG_IMMERSIVE.
        // Or for "sticky immersive," replace it with SYSTEM_UI_FLAG_IMMERSIVE_STICKY
        window.decorView.systemUiVisibility = (View.SYSTEM_UI_FLAG_IMMERSIVE
                // Set the content to appear under the system bars so that the
                // content doesn't resize when the system bars hide and show.
                or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                // Hide the nav bar and status bar
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN)
    }
}



@Composable
fun VectorImage(id: Int, tint: Color = Color.Transparent) {
    val vector = +vectorResource(id)
    WithDensity {
        Container(
            width = vector.defaultWidth.toDp(),
            height = vector.defaultHeight.toDp()
        ) {
            DrawVector(vectorImage = vector, tintColor = tint)
        }
    }
}


@Composable
fun App() {
    val image = +imageResource(R.drawable.screenbg)
    DrawImage(image = image)

    Align(Alignment.Center) {
        Container(modifier = Height(330.dp)) {
            Clip(shape = RoundedCornerShape(300.dp)) {
                VectorImage(id = R.drawable.ic_fish_monogram)
            }

        }
    }
    Column() {
        Align(Alignment.Center) {
            Padding(top = 400.dp) {
                Text(
                    text = "Happy Alpha Fishing",
                    style = TextStyle(color = Color.White, fontSize = 22.sp, fontWeight = FontWeight.Bold)
                )
            }
        }
    }

    Align(Alignment.BottomCenter){
        Padding(padding = -72.dp) {
            Text(
                text = "Ex Unum, Pluribus",
                style = TextStyle(color = Color.White, fontSize = 18.sp)
            )
        }
    }
    Align(Alignment.BottomCenter){
        Padding(padding = -52.dp) {
            Text(
                text = "Powered by Kotlin Multiplatform",
                style = TextStyle(color = Color.White, fontSize = 18.sp)
            )
        }
    }


}

@Preview
@Composable
fun DefaultPreview() {
   // MaterialTheme {
        App()
   // }
}

