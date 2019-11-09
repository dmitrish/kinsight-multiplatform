package com.kinsight.kinsightmultiplatform.api

import android.R

import android.os.Build
import android.util.Log
import org.java_websocket.client.WebSocketClient
import org.java_websocket.handshake.ServerHandshake
import java.net.URI
import java.net.URISyntaxException
import java.util.*


class WsClient(
    val address: String
) : WebSocketClient(URI(address)) {

    override fun onOpen(handshakedata: ServerHandshake?) {
        println(handshakedata)
    }

    override fun onClose(code: Int, reason: String?, remote: Boolean)  = Unit

    override fun onMessage(message: String?) {
       println(message)
    }



    override fun onError(ex: Exception?) {
        println(ex?.message)
    }
}