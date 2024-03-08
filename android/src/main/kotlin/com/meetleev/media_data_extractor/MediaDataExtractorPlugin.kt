package com.meetleev.media_data_extractor

import android.media.MediaExtractor
import android.media.MediaFormat
import android.media.MediaMetadataRetriever
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.io.IOException
import java.util.concurrent.LinkedBlockingQueue
import java.util.concurrent.ThreadPoolExecutor
import java.util.concurrent.TimeUnit


/** MediaDataExtractorPlugin */
class MediaDataExtractorPlugin : FlutterPlugin, MediaDataExtractorApi {
    private var pluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    companion object {
        private const val poolSize = 2
        private var threadPools: ThreadPoolExecutor = ThreadPoolExecutor(poolSize, Int.MAX_VALUE, 1, TimeUnit.MINUTES, LinkedBlockingQueue())

        fun runOnBackground(runnable: () -> Unit) {
            threadPools.execute(runnable)
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = flutterPluginBinding
        MediaDataExtractorApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = null
    }

    override fun getVideoData(dataSource: MediaDataSource, callback: (Result<VideoData>) -> Unit) {
        runOnBackground {
            val metaRetriever = MediaMetadataRetriever()
            val url = dataSource.url
            val retriever = MediaExtractor()
            try {
                when (dataSource.type) {
                    MediaDataSourceType.ASSET -> {
                        val packageName = dataSource.packageName
                        val mediaUrl: String = if (!packageName.isNullOrEmpty()) {
                            pluginBinding!!.flutterAssets.getAssetFilePathByName(url, packageName)
                        } else {
                            pluginBinding!!.flutterAssets.getAssetFilePathByName(url)
                        }
                        val assetFileDescriptor = pluginBinding!!.applicationContext.assets.openFd(mediaUrl)
                        retriever.setDataSource(assetFileDescriptor.fileDescriptor, assetFileDescriptor.startOffset, assetFileDescriptor.length)
                        metaRetriever.setDataSource(assetFileDescriptor.fileDescriptor, assetFileDescriptor.startOffset, assetFileDescriptor.length)
                        assetFileDescriptor.close()
                    }

                    MediaDataSourceType.FILE -> {
                        retriever.setDataSource(url)
                        metaRetriever.setDataSource(url)
                    }

                    MediaDataSourceType.NETWORK -> {
                        retriever.setDataSource(url, hashMapOf())
                        metaRetriever.setDataSource(url, hashMapOf())
                    }
                }
                val tracks: MutableList<VideoTrackData> = mutableListOf()
                val trackCount = retriever.trackCount
                for (i in 0 until trackCount) {
                    val format = retriever.getTrackFormat(i)
                    val mime = format.getString(MediaFormat.KEY_MIME)
                    if (mime?.startsWith("video/") == true) {
                        val frameRate = format.getInteger(MediaFormat.KEY_FRAME_RATE)
                        val duration = format.getLong(MediaFormat.KEY_DURATION)
                        val bitRate = format.getInteger(MediaFormat.KEY_BIT_RATE)
                        val width = format.getInteger(MediaFormat.KEY_WIDTH)
                        val height = format.getInteger(MediaFormat.KEY_HEIGHT)
                        val meta = VideoTrackData(
                                frameRate = frameRate.toDouble(), duration = duration / 1000,
                                bitRate = bitRate.toDouble(), width = width.toDouble(), height = height.toDouble(),
//                                mimeType = mime,
                        )
                        tracks.add(meta)
                    }
                }
                val artist = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST)
                val title = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE)
                val album = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUM)
                val genre = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_GENRE)
                val date = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DATE)
//                val location = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_LOCATION)
                val author = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_AUTHOR)
                val meta = VideoMetaData(artist = artist, title = title,
                        album = album, genre = genre, author = author, date = date)
                callback(Result.success(VideoData(meta = meta, tracks = tracks)))
            } catch (e: IOException) {
                e.printStackTrace()
                callback(Result.failure(e))
            } finally {
                retriever.release()
                metaRetriever.release()
            }
        }
    }
}