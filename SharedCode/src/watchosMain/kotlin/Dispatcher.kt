package com.kinsight.kinsightmultiplatform


import kotlinx.cinterop.*
import kotlin.coroutines.*
import kotlinx.coroutines.*

import platform.darwin.*
import kotlin.native.concurrent.freeze

internal actual val ApplicationDispatcher: CoroutineDispatcher =
    NsQueueDispatcher(dispatch_get_main_queue())

internal class NsQueueDispatcher(
    private val dispatchQueue: dispatch_queue_t
) : CoroutineDispatcher() {
    override fun dispatch(context: CoroutineContext, block: Runnable) {
        dispatch_async(dispatchQueue) {
            block.run()
        }
    }
}
/*

fun hexStringToUIColor (hex: NSString) : UIColor {
    var cString:String = hex.toString() //.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.startsWith("#")) {
        cString.removePrefix("#")
    }

    if ((cString.count()) != 6) {
        return UIColor.grayColor
    }

    var rgbValue: UInt64 = 0.toULong()

    var cp: CPrimitiveVar = rgbValue.convert()

  //  var cpt: CPointer<UInt64>? = rgbValue.toC

    NSScanner(cString).scanHexInt(cp.ptr.reinterpret())

    val red = ((rgbValue and 0x00FF00) shr 8) / 255.0)

    val uiColor = UIColor(displayP3Red = 3.0, green = 3.0, blue = 2.0, alpha =  3.0)

    return UIColor(
        UIColor.redColor = 4.0,
    UIColor.greenColor: CGFloat((rgbValue and 0x00FF00) shr 8) / 255.0,
    UIColor.blueColor: CGFloat(rgbValue and 0x0000FF) / 255.0,
    alpha: CGFloat(1.0)
    )
}


 */


