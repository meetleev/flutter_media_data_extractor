// Autogenerated from Pigeon (v20.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")

package com.meetleev.media_data_extractor

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is FlutterError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class MediaDataSourceType(val raw: Int) {
  /** The video was included in the app's asset files. */
  ASSET(0),
  /** The video was downloaded from the internet. */
  NETWORK(1),
  /** The video was loaded off of the local filesystem. */
  FILE(2);

  companion object {
    fun ofRaw(raw: Int): MediaDataSourceType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class MediaDataSource (
  /** Type of source of video */
  val type: MediaDataSourceType,
  /** Url of the video */
  val url: String,
  /** Only set for [asset] videos. The package that the asset was loaded from. */
  val packageName: String? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): MediaDataSource {
      val type = __pigeon_list[0] as MediaDataSourceType
      val url = __pigeon_list[1] as String
      val packageName = __pigeon_list[2] as String?
      return MediaDataSource(type, url, packageName)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      type,
      url,
      packageName,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class VideoTrackData (
  /** A key describing the frame rate of a video format in frames/sec. */
  val frameRate: Double? = null,
  /** A key describing the width of the content in a video format. */
  val width: Double? = null,
  /** A key describing the height of the content in a video format. */
  val height: Double? = null,
  /** encoder-only, desired bitrate in bits/second */
  val bitRate: Double? = null,
  /** the duration of the content (in milliseconds) */
  val duration: Long? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): VideoTrackData {
      val frameRate = __pigeon_list[0] as Double?
      val width = __pigeon_list[1] as Double?
      val height = __pigeon_list[2] as Double?
      val bitRate = __pigeon_list[3] as Double?
      val duration = __pigeon_list[4].let { num -> if (num is Int) num.toLong() else num as Long? }
      return VideoTrackData(frameRate, width, height, bitRate, duration)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      frameRate,
      width,
      height,
      bitRate,
      duration,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class VideoMetaData (
  /** The artist of the media. */
  val artist: String? = null,
  /** The title of the media. */
  val title: String? = null,
  /** The album of the media. */
  val album: String? = null,
  /** The genre of the media. */
  val genre: String? = null,
  /** The language of the media. */
  val language: String? = null,
  /** The author of the media. */
  val author: String? = null,
  /** The date of the media. */
  val date: String? = null

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): VideoMetaData {
      val artist = __pigeon_list[0] as String?
      val title = __pigeon_list[1] as String?
      val album = __pigeon_list[2] as String?
      val genre = __pigeon_list[3] as String?
      val language = __pigeon_list[4] as String?
      val author = __pigeon_list[5] as String?
      val date = __pigeon_list[6] as String?
      return VideoMetaData(artist, title, album, genre, language, author, date)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      artist,
      title,
      album,
      genre,
      language,
      author,
      date,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class VideoData (
  val meta: VideoMetaData? = null,
  val tracks: List<VideoTrackData?>

) {
  companion object {
    @Suppress("LocalVariableName")
    fun fromList(__pigeon_list: List<Any?>): VideoData {
      val meta = __pigeon_list[0] as VideoMetaData?
      val tracks = __pigeon_list[1] as List<VideoTrackData?>
      return VideoData(meta, tracks)
    }
  }
  fun toList(): List<Any?> {
    return listOf(
      meta,
      tracks,
    )
  }
}
private object MessagesPigeonCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MediaDataSource.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          VideoTrackData.fromList(it)
        }
      }
      131.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          VideoMetaData.fromList(it)
        }
      }
      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          VideoData.fromList(it)
        }
      }
      133.toByte() -> {
        return (readValue(buffer) as Int?)?.let {
          MediaDataSourceType.ofRaw(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is MediaDataSource -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is VideoTrackData -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }
      is VideoMetaData -> {
        stream.write(131)
        writeValue(stream, value.toList())
      }
      is VideoData -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }
      is MediaDataSourceType -> {
        stream.write(133)
        writeValue(stream, value.raw)
      }
      else -> super.writeValue(stream, value)
    }
  }
}


/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface MediaDataExtractorApi {
  fun getVideoData(dataSource: MediaDataSource, callback: (Result<VideoData>) -> Unit)

  companion object {
    /** The codec used by MediaDataExtractorApi. */
    val codec: MessageCodec<Any?> by lazy {
      MessagesPigeonCodec
    }
    /** Sets up an instance of `MediaDataExtractorApi` to handle messages through the `binaryMessenger`. */
    @JvmOverloads
    fun setUp(binaryMessenger: BinaryMessenger, api: MediaDataExtractorApi?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.media_data_extractor.MediaDataExtractorApi.getVideoData$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val dataSourceArg = args[0] as MediaDataSource
            api.getVideoData(dataSourceArg) { result: Result<VideoData> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
