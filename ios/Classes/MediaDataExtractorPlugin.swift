import Flutter
import UIKit
import AVFoundation

public class MediaDataExtractorPlugin: NSObject, FlutterPlugin, MediaDataExtractorApi {
    private let registrar: FlutterPluginRegistrar
    
    init(_ registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = MediaDataExtractorPlugin(registrar)
        MediaDataExtractorApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
    }

    func getVideoData(dataSource: MediaDataSource, completion: @escaping (Result<VideoData, Error>) -> Void) {
        let url = dataSource.url
        var videoURL: URL?
        switch dataSource.type {
        case .asset:
            let package = dataSource.packageName
            var mediaUrl: String
            if nil != package && !package!.isEmpty {
                mediaUrl = registrar.lookupKey(forAsset: url, fromPackage: package!)
            } else {
                mediaUrl = registrar.lookupKey(forAsset: url)
            }
            videoURL = Bundle.main.url(forResource: mediaUrl, withExtension: nil)
        case .network:
            videoURL = URL(string: url)
        case .file:
            videoURL = URL(fileURLWithPath: url)
        }
    
        let asset = AVAsset(url: videoURL!)
        let keys = ["tracks", "metadata"]
        asset.loadValuesAsynchronously(forKeys: keys, completionHandler: {
            var error: NSError? = nil
            var status = asset.statusOfValue(forKey: "metadata", error: &error)
            var meta:VideoMetaData?
            if .loaded == status {
                let metaItems = asset.metadata
                for item in metaItems {
                    if nil == meta {
                        meta = VideoMetaData()
                    }
                    if .commonKeyArtist == item.commonKey {
                        meta!.artist = item.value as? String
                    } else if .commonKeyTitle == item.commonKey {
                        meta!.title = item.value as? String
                    } else if .commonKeyAlbumName == item.commonKey {
                        meta!.album = item.value as? String
                    } else if .commonKeyLanguage == item.commonKey {
                        meta!.language = item.value as? String
                    } else if .commonKeyAuthor == item.commonKey {
                        meta!.author = item.value as? String
                    } else if .commonKeyCreationDate == item.commonKey {
                        meta!.date = item.value as? String
                    } else {
                        let key = item.keyString()
                        if nil == meta?.date {
                            if "©day" == key {
                                meta!.date = item.value as? String
                            }
                            continue
                        }
                        if "©gen" == key {
                            meta!.genre = item.value as? String
                        } else {
                        }
                    }
                }
            }
            status = .loading
            status = asset.statusOfValue(forKey: "tracks", error: &error)
            var tracks:[VideoTrackData] = []
            if .loaded == status {
                let videoTracks = asset.tracks(withMediaType: .video)
                for videoTrack in videoTracks {
                    let width: Double = round(videoTrack.naturalSize.width * 100) / 100
                    let height: Double = round(videoTrack.naturalSize.height * 100) / 100
                    var track = VideoTrackData(frameRate: Double( videoTrack.nominalFrameRate), width: width, height: height, bitRate: Double(videoTrack.estimatedDataRate))
                    let duration = videoTrack.timeRange.duration
                    let durationSeconds = CMTimeGetSeconds(duration)
                    track.duration = Int64(durationSeconds * 1000)
                    tracks.append(track)
                }
            }
            let videoData = VideoData(meta: meta, tracks:tracks)
            DispatchQueue.main.async {
                completion(.success(videoData))
            }
        })
    }
}
