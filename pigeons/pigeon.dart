// ignore: prefer-match-file-name

import 'package:pigeon/pigeon.dart';

enum MediaDataSourceType {
  /// The video was included in the app's asset files.
  asset,

  /// The video was downloaded from the internet.
  network,

  /// The video was loaded off of the local filesystem.
  file,
}

class MediaDataSource {
  /// Type of source of video
  final MediaDataSourceType type;

  /// Url of the video
  final String url;

  /// Only set for [asset] videos. The package that the asset was loaded from.
  final String? packageName;

  MediaDataSource(
    this.type,
    this.url, {
    this.packageName,
  });
}

class VideoTrackData {
  /// A key describing the frame rate of a video format in frames/sec.
  double? frameRate;

  /// A key describing the width of the content in a video format.
  double? width;

  /// A key describing the height of the content in a video format.
  double? height;

  /// encoder-only, desired bitrate in bits/second
  double? bitRate;

  /// the duration of the content (in milliseconds)
  int? duration;

  /// A key describing the mime type of the MediaFormat.
// String? mimeType;
}

class VideoMetaData {
  /// The artist of the media.
  String? artist;

  /// The title of the media.
  String? title;

  /// The album of the media.
  String? album;

  /// The genre of the media.
  String? genre;

  /// The language of the media.
  String? language;

  /// The author of the media.
  String? author;

  /// The date of the media.
  String? date;
}

class VideoData {
  final VideoMetaData? meta;
  final List<VideoTrackData?> tracks;

  VideoData({required this.meta, required this.tracks});
}

@ConfigurePigeon(PigeonOptions(
    dartOut: 'lib/src/messages/messages.dart',
    dartOptions: DartOptions(),
    swiftOut: 'ios/Classes/messages.g.swift',
    swiftOptions: SwiftOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/meetleev/media_data_extractor/Messages.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.meetleev.media_data_extractor')))

@HostApi()
abstract class MediaDataExtractorApi {
  @async
  VideoData getVideoData(MediaDataSource dataSource);
}

