# media_data_extractor

[![Pub](https://img.shields.io/pub/v/media_data_extractor.svg?style=flat-square)](https://pub.dev/packages/media_data_extractor)
[![support](https://img.shields.io/badge/platform-android%20|%20ios%20-blue.svg)](https://pub.dev/packages/media_data_extractor)


The package is a Flutter plugin that provides functionality to extract metadata from video files. This plugin allows developers to retrieve various metadata information from video files, such as duration, resolution, bitrate, codec, and more.

## Usage

``` dart
final mediaDataExtractorPlugin = MediaDataExtractor();
final metas = await mediaDataExtractorPlugin
                    .getVideoData(MediaDataSource(
                        type: MediaDataSourceType.asset,
                        url: 'assetVideoUrl'));
```
