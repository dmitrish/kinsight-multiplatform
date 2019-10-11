package com.kinsight.kinsightmultiplatform

expect fun platformName(): String

fun createApplicationScreenMessage(): String {
    return "Kotlin Alpha Capture Concept on ${platformName()}"
}

