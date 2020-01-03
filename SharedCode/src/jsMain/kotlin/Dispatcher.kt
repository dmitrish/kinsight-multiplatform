package com.kinsight.kinsightmultiplatform


import kotlin.coroutines.*
import kotlinx.coroutines.*

import kotlinx.coroutines.Dispatchers.Default
import kotlin.coroutines.CoroutineContext

internal actual val ApplicationDispatcher: CoroutineDispatcher = Default