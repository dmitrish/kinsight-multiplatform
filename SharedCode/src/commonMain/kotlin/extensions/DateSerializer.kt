package com.kinsight.kinsightmultiplatform.extensions

/*
import com.soywiz.klock.*
import kotlinx.serialization.*
import kotlinx.serialization.internal.StringDescriptor


@Serializer(forClass = Date::class)
object DateSerializer: KSerializer<DateTimeTz> {
    private val df: DateFormat = DateFormat("dd/MM/yyyy HH:mm:ss.SSS")

    override val descriptor: SerialDescriptor =
        StringDescriptor.withName("WithCustomDefault")

    override fun serialize(encoder: Encoder, obj: DateTimeTz) {
        encoder.encodeString(df.format(obj))
    }

    override fun deserialize(decoder: Decoder): DateTimeTz {
        return df.parse(decoder.decodeString())
    }
}
*/


