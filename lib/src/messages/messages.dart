// Autogenerated from Pigeon (v22.7.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

enum MediaDataSourceType {
  /// The video was included in the app's asset files.
  asset,

  /// The video was downloaded from the internet.
  network,

  /// The video was loaded off of the local filesystem.
  file,
}

class MediaDataSource {
  MediaDataSource({
    required this.type,
    required this.url,
    this.packageName,
  });

  /// Type of source of video
  MediaDataSourceType type;

  /// Url of the video
  String url;

  /// Only set for [asset] videos. The package that the asset was loaded from.
  String? packageName;

  Object encode() {
    return <Object?>[
      type,
      url,
      packageName,
    ];
  }

  static MediaDataSource decode(Object result) {
    result as List<Object?>;
    return MediaDataSource(
      type: result[0]! as MediaDataSourceType,
      url: result[1]! as String,
      packageName: result[2] as String?,
    );
  }
}

class VideoTrackData {
  VideoTrackData({
    this.frameRate,
    this.width,
    this.height,
    this.bitRate,
    this.duration,
  });

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

  Object encode() {
    return <Object?>[
      frameRate,
      width,
      height,
      bitRate,
      duration,
    ];
  }

  static VideoTrackData decode(Object result) {
    result as List<Object?>;
    return VideoTrackData(
      frameRate: result[0] as double?,
      width: result[1] as double?,
      height: result[2] as double?,
      bitRate: result[3] as double?,
      duration: result[4] as int?,
    );
  }
}

class VideoMetaData {
  VideoMetaData({
    this.artist,
    this.title,
    this.album,
    this.genre,
    this.language,
    this.author,
    this.date,
  });

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

  Object encode() {
    return <Object?>[
      artist,
      title,
      album,
      genre,
      language,
      author,
      date,
    ];
  }

  static VideoMetaData decode(Object result) {
    result as List<Object?>;
    return VideoMetaData(
      artist: result[0] as String?,
      title: result[1] as String?,
      album: result[2] as String?,
      genre: result[3] as String?,
      language: result[4] as String?,
      author: result[5] as String?,
      date: result[6] as String?,
    );
  }
}

class VideoData {
  VideoData({
    this.meta,
    required this.tracks,
  });

  VideoMetaData? meta;

  List<VideoTrackData?> tracks;

  Object encode() {
    return <Object?>[
      meta,
      tracks,
    ];
  }

  static VideoData decode(Object result) {
    result as List<Object?>;
    return VideoData(
      meta: result[0] as VideoMetaData?,
      tracks: (result[1] as List<Object?>?)!.cast<VideoTrackData?>(),
    );
  }
}

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is MediaDataSourceType) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is MediaDataSource) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is VideoTrackData) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is VideoMetaData) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is VideoData) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : MediaDataSourceType.values[value];
      case 130:
        return MediaDataSource.decode(readValue(buffer)!);
      case 131:
        return VideoTrackData.decode(readValue(buffer)!);
      case 132:
        return VideoMetaData.decode(readValue(buffer)!);
      case 133:
        return VideoData.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class MediaDataExtractorApi {
  /// Constructor for [MediaDataExtractorApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MediaDataExtractorApi(
      {BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix =
            messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  Future<VideoData> getVideoData(MediaDataSource dataSource) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.media_data_extractor.MediaDataExtractorApi.getVideoData$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[dataSource]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as VideoData?)!;
    }
  }
}
