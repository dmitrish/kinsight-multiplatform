package com.kinsight.kinsightmultiplatform.kinsightmultiplatformjetpackcomposeui

import androidx.compose.Composable
import androidx.compose.unaryPlus
import androidx.ui.core.*
import androidx.ui.foundation.DrawImage
import androidx.ui.foundation.shape.corner.RoundedCornerShape
import androidx.ui.graphics.Color
import androidx.ui.layout.*
import androidx.ui.material.Button
import androidx.ui.material.ButtonStyle
import androidx.ui.material.MaterialTheme
import androidx.ui.res.imageResource
import androidx.ui.text.TextStyle
import androidx.ui.tooling.preview.Preview

@Composable
fun WelcomeScreen( changeScreen:  ()-> Unit) {
    //screen.
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
            Padding(top = 300.dp) {
                /* Text(
                     text = "Happy Alpha Fishing",
                     style = TextStyle(color = Color.White, fontSize = 22.sp, fontWeight = FontWeight.Bold)
                 )*/
                Button(
                    text = "Happy Alpha Fishing",
                    style = ButtonStyle(
                        color = Color.Transparent,
                        shape = (+MaterialTheme.shapes()).button,
                        paddings = EdgeInsets(
                            left = 0.dp,
                            top = 0.dp,
                            right = 0.dp,
                            bottom = 0.dp
                        ),
                        textStyle = TextStyle(color = Color.White, fontSize = 22.sp),
                        rippleColor = Color.Green
                    ),
                    onClick = {
                       changeScreen()
                    }
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
    /*Align(Alignment.BottomCenter){
        Padding(padding = -72.dp) {
            Button(
                text = "Ex Unum, Pluribus",

                style = TextButtonStyle()
            )
        }
    }*/
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
    MaterialTheme {
       // WelcomeScreen(Screen)
    }
}