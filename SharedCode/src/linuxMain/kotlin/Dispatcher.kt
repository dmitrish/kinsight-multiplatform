package com.kinsight.kinsightmultiplatform


import kotlinx.cinterop.*
import kotlin.coroutines.*
import kotlinx.coroutines.*

import kotlin.native.concurrent.freeze


internal actual val ApplicationDispatcher: CoroutineDispatcher = Dispatchers.Default