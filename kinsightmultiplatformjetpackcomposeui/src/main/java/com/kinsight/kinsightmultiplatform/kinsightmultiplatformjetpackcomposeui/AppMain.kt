package com.kinsight.kinsightmultiplatform.kinsightmultiplatformjetpackcomposeui

import androidx.compose.Composable
import androidx.compose.state
import androidx.compose.unaryPlus
import androidx.ui.animation.Crossfade
import androidx.ui.material.MaterialTheme
import androidx.ui.material.surface.Surface


@Composable
fun AppMain() {
    var currentScreen by +state<Screen> { Screen.Welcome }
    //var viewModel by +state <IdeasViewModel> {IdeasViewModel()}

   // currentScreen = Screen.Ideas()

    fun changeScreen(){
        currentScreen = Screen.Ideas()
    }

    MaterialTheme() {
        Crossfade(currentScreen) { screen ->
           // Surface() {
                when (screen) {
                    is Screen.Welcome -> WelcomeScreen(changeScreen = { changeScreen() })
                    is Screen.Ideas -> ideasScreen()
                }
           // }
        }
    }
}



public sealed class Screen {
    object Welcome : Screen()
    class Ideas() : Screen()
}