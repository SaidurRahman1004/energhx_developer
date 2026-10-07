import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class VideoCacheService {
  VideoCacheService._();

  static Directory? _cacheDir;

  static Future<Directory> _getCacheDirectory() async {
    if (_cacheDir != null && await _cacheDir!.exists()) {
      return _cacheDir!;
    }
    final baseDir = await getTemporaryDirectory();
    final videoDir = Directory('${baseDir.path}/video_cache');
    if (!await videoDir.exists()) {
      await videoDir.create(recursive: true);
    }
    _cacheDir = videoDir;
    return videoDir;
  }

  /// Returns the cached file if it exists and is complete; otherwise null.
  static Future<File?> getCachedVideoFile(String url) async {
    try {
      final dir = await _getCacheDirectory();
      final fileName = 'video_${url.hashCode.abs()}.mp4';
      final file = File('${dir.path}/$fileName');

      if (await file.exists() && await file.length() > 50000) {
        debugPrint('[VideoCacheService] Cache HIT for: $url -> ${file.path}');
        return file;
      }
    } catch (e) {
      debugPrint('[VideoCacheService] Cache check error: $e');
    }
    return null;
  }

  /// Downloads and caches the video file in the background for instant future loads.
  static Future<File?> cacheVideo(String url) async {
    try {
      final dir = await _getCacheDirectory();
      final fileName = 'video_${url.hashCode.abs()}.mp4';
      final file = File('${dir.path}/$fileName');

      if (await file.exists() && await file.length() > 50000) {
        return file;
      }

      debugPrint('[VideoCacheService] Caching video from: $url');
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 15);
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();

      if (response.statusCode == 200) {
        final tempFile = File('${dir.path}/$fileName.tmp');
        final sink = tempFile.openWrite();
        await response.pipe(sink);
        await sink.close();

        if (await tempFile.exists() && await tempFile.length() > 50000) {
          if (await file.exists()) {
            await file.delete();
          }
          await tempFile.rename(file.path);
          debugPrint('[VideoCacheService] Cached successfully: ${file.path}');
          return file;
        }
      }
    } catch (e) {
      debugPrint('[VideoCacheService] Error caching video: $e');
    }
    return null;
  }
}
