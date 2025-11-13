import 'src/messages/messages.dart';
export 'src/messages/messages.dart'
    show
        MediaDataSource,
        VideoMetaData,
        MediaDataSourceType,
        VideoData,
        VideoTrackData;

extension VideoTrackDataEx on VideoTrackData {
  String get description =>
      '{ frameRate: $frameRate, width: $width, height: $height, '
      'bitRate: $bitRate, duration: $duration}';
}

extension VideoMetaDataEx on VideoMetaData {
  String get description =>
      '{title: $title, artist: $artist, album: $album, '
      'genre: $genre language: $language, author: $author, '
      'date: $date}';
}

extension VideoDataEx on VideoData {
  String get description {
    StringBuffer stringBuffer = StringBuffer();
    for (final track in tracks) {
      stringBuffer.write(track?.description);
    }
    return '{ meta: ${meta?.description}, tracks:${stringBuffer.toString()}';
  }
}

class MediaDataExtractor {
  final MediaDataExtractorApi _api = MediaDataExtractorApi();

  Future<VideoData> getVideoData(MediaDataSource dataSource) {
    return _api.getVideoData(dataSource);
  }
}
