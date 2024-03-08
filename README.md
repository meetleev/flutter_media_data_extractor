# media_data_extractor

The package is a Flutter plugin that provides functionality to extract metadata from video files. This plugin allows developers to retrieve various metadata information from video files, such as duration, resolution, bitrate, codec, and more.

## Usage

``` dart
final mediaDataExtractorPlugin = MediaDataExtractor();
final metas = await mediaDataExtractorPlugin
                    .getVideoData(MediaDataSource(
                        type: MediaDataSourceType.asset,
                        url: 'assetVideoUrl'));
```
