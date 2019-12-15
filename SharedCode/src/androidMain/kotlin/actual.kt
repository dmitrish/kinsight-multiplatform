package com.kinsight.kinsightmultiplatform

import com.kinsight.kinsightmultiplatform.models.IdeaModel
import com.kinsight.kinsightmultiplatform.models.*

actual fun platformName(): String {
    return "Android"
}

//actual interface Codable {}

actual typealias Parcelable = android.os.Parcelable

actual typealias Parcelize = kotlinx.android.parcel.Parcelize


