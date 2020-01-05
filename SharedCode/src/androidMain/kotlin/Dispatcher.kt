package com.kinsight.kinsightmultiplatform



import io.ktor.client.engine.HttpClientEngine
import io.ktor.client.engine.cio.CIO
import kotlinx.coroutines.*

//actual typealias HttpClientEngine: io.ktor.client.engine.cio.CIO

internal actual val ApplicationDispatcher: CoroutineDispatcher = Dispatchers.Default


//actual interface ClientEngine : HttpClientEngine