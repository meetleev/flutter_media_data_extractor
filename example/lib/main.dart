import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_data_extractor/media_data_extractor.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mediaDataExtractorPlugin = MediaDataExtractor();
  final remoteVideoUrl =
      'https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4';
  final assetVideoUrl = 'assets/test.mp4';
  final fileVideoName = 'Butterfly-209.mp4';
  final ValueNotifier<String> _valueNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Example'),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 250,
                child: ValueListenableBuilder(
                  valueListenable: _valueNotifier,
                  builder: (BuildContext context, String value, Widget? child) {
                    return Text(value);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final metas = await _mediaDataExtractorPlugin
                            .getVideoData(MediaDataSource(
                                type: MediaDataSourceType.network,
                                url: remoteVideoUrl));
                        _valueNotifier.value = _printMetas(metas);
                      },
                      child: const Text('Network')),
                  ElevatedButton(
                      onPressed: () async {
                        final metas = await _mediaDataExtractorPlugin
                            .getVideoData(MediaDataSource(
                                type: MediaDataSourceType.asset,
                                url: assetVideoUrl));
                        _valueNotifier.value = _printMetas(metas);
                      },
                      child: const Text('Assets')),
                  ElevatedButton(
                      onPressed: () async {
                        final cacheDir = await getApplicationCacheDirectory();
                        final path = '${cacheDir.path}/$fileVideoName';
                        File f = File(path);
                        if (!f.existsSync()) {
                          final data = await rootBundle.load(assetVideoUrl);
                          f.writeAsBytes(data.buffer.asUint8List());
                        }
                        final metas = await _mediaDataExtractorPlugin
                            .getVideoData(MediaDataSource(
                                type: MediaDataSourceType.file, url: path));
                        _valueNotifier.value = _printMetas(metas);
                      },
                      child: const Text('File'))
                ],
              )
            ],
          )),
    );
  }

  String _printMetas(VideoData data) {
    debugPrint('_printMetas:${data.description}');
    return data.description;
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }
}
