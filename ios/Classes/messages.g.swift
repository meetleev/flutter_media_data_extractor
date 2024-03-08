// Autogenerated from Pigeon (v17.1.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum MediaDataSourceType: Int {
  /// The video was included in the app's asset files.
  case asset = 0
  /// The video was downloaded from the internet.
  case network = 1
  /// The video was loaded off of the local filesystem.
  case file = 2
}

/// Generated class from Pigeon that represents data sent in messages.
struct MediaDataSource {
  /// Type of source of video
  var type: MediaDataSourceType
  /// Url of the video
  var url: String
  /// Only set for [asset] videos. The package that the asset was loaded from.
  var packageName: String? = nil

  static func fromList(_ list: [Any?]) -> MediaDataSource? {
    let type = MediaDataSourceType(rawValue: list[0] as! Int)!
    let url = list[1] as! String
    let packageName: String? = nilOrValue(list[2])

    return MediaDataSource(
      type: type,
      url: url,
      packageName: packageName
    )
  }
  func toList() -> [Any?] {
    return [
      type.rawValue,
      url,
      packageName,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct VideoTrackData {
  /// A key describing the frame rate of a video format in frames/sec.
  var frameRate: Double? = nil
  /// A key describing the width of the content in a video format.
  var width: Double? = nil
  /// A key describing the height of the content in a video format.
  var height: Double? = nil
  /// encoder-only, desired bitrate in bits/second
  var bitRate: Double? = nil
  /// the duration of the content (in milliseconds)
  var duration: Int64? = nil

  static func fromList(_ list: [Any?]) -> VideoTrackData? {
    let frameRate: Double? = nilOrValue(list[0])
    let width: Double? = nilOrValue(list[1])
    let height: Double? = nilOrValue(list[2])
    let bitRate: Double? = nilOrValue(list[3])
    let duration: Int64? = isNullish(list[4]) ? nil : (list[4] is Int64? ? list[4] as! Int64? : Int64(list[4] as! Int32))

    return VideoTrackData(
      frameRate: frameRate,
      width: width,
      height: height,
      bitRate: bitRate,
      duration: duration
    )
  }
  func toList() -> [Any?] {
    return [
      frameRate,
      width,
      height,
      bitRate,
      duration,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct VideoMetaData {
  /// The artist of the media.
  var artist: String? = nil
  /// The title of the media.
  var title: String? = nil
  /// The album of the media.
  var album: String? = nil
  /// The genre of the media.
  var genre: String? = nil
  /// The language of the media.
  var language: String? = nil
  /// The author of the media.
  var author: String? = nil
  /// The date of the media.
  var date: String? = nil

  static func fromList(_ list: [Any?]) -> VideoMetaData? {
    let artist: String? = nilOrValue(list[0])
    let title: String? = nilOrValue(list[1])
    let album: String? = nilOrValue(list[2])
    let genre: String? = nilOrValue(list[3])
    let language: String? = nilOrValue(list[4])
    let author: String? = nilOrValue(list[5])
    let date: String? = nilOrValue(list[6])

    return VideoMetaData(
      artist: artist,
      title: title,
      album: album,
      genre: genre,
      language: language,
      author: author,
      date: date
    )
  }
  func toList() -> [Any?] {
    return [
      artist,
      title,
      album,
      genre,
      language,
      author,
      date,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct VideoData {
  var meta: VideoMetaData? = nil
  var tracks: [VideoTrackData?]

  static func fromList(_ list: [Any?]) -> VideoData? {
    var meta: VideoMetaData? = nil
    if let metaList: [Any?] = nilOrValue(list[0]) {
      meta = VideoMetaData.fromList(metaList)
    }
    let tracks = list[1] as! [VideoTrackData?]

    return VideoData(
      meta: meta,
      tracks: tracks
    )
  }
  func toList() -> [Any?] {
    return [
      meta?.toList(),
      tracks,
    ]
  }
}

private class MediaDataExtractorApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 128:
      return MediaDataSource.fromList(self.readValue() as! [Any?])
    case 129:
      return VideoData.fromList(self.readValue() as! [Any?])
    case 130:
      return VideoMetaData.fromList(self.readValue() as! [Any?])
    case 131:
      return VideoTrackData.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class MediaDataExtractorApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? MediaDataSource {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? VideoData {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? VideoMetaData {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? VideoTrackData {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class MediaDataExtractorApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return MediaDataExtractorApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return MediaDataExtractorApiCodecWriter(data: data)
  }
}

class MediaDataExtractorApiCodec: FlutterStandardMessageCodec {
  static let shared = MediaDataExtractorApiCodec(readerWriter: MediaDataExtractorApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol MediaDataExtractorApi {
  func getVideoData(dataSource: MediaDataSource, completion: @escaping (Result<VideoData, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class MediaDataExtractorApiSetup {
  /// The codec used by MediaDataExtractorApi.
  static var codec: FlutterStandardMessageCodec { MediaDataExtractorApiCodec.shared }
  /// Sets up an instance of `MediaDataExtractorApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: MediaDataExtractorApi?) {
    let getVideoDataChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.media_data_extractor.MediaDataExtractorApi.getVideoData", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getVideoDataChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let dataSourceArg = args[0] as! MediaDataSource
        api.getVideoData(dataSource: dataSourceArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      getVideoDataChannel.setMessageHandler(nil)
    }
  }
}