import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/common/helper/cover_matcher.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entites/song/song.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getAllCovers();
  Future<Either> getPlaylist();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  @override
  Future<Either<dynamic, dynamic>> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];

      // Get covers from Supabase
      print('🔍 Fetching covers from Supabase...');
      var coversResult = await getAllCovers();
      Map<String, String> coverUrls = {};

      coversResult.fold((error) => print('❌ Error getting covers: $error'), (
        covers,
      ) {
        for (var cover in covers) {
          String fileName = cover['name'];
          String songName = fileName
              .replaceAll('.jpg', '')
              .replaceAll('.png', '')
              .replaceAll('.jpeg', '');
          coverUrls[songName] = cover['url'];
        }
      });

      // Get songs from Firebase Firestore
      print('🔍 Fetching songs from Firebase...');
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .limit(10)
          .get();

      print('📊 Found ${data.docs.length} songs in Firebase');

      for (var element in data.docs) {
        var songData = element.data();

        String title = songData['title'] ?? '';
        String artist = songData['artist'] ?? '';
        dynamic durationField =
            songData['duration'] ?? 180; // Get real duration from Firebase

        num duration;

        if (durationField is String) {
          duration = double.tryParse(durationField) ?? 180.0;
        } else if (durationField is num) {
          duration = durationField;
        } else {
          duration = 180;
        }
        Timestamp releaseDate = songData['releaseDate'] ?? Timestamp.now();

        // Match cover URL
        String coverUrl = CoverMatcher.matchCoverUrl(title, artist, coverUrls);

        print('🎵 Song: $artist - $title');
        print('⏱️ Duration: ${duration}s');
        print('🖼️ Cover: $coverUrl');
        // Create SongEntity directly to avoid SongModel parsing issues
        var songEntity = SongEntity(
          title: title,
          artist: artist,
          duration: duration,
          releaseData: releaseDate,
          coverUrl: coverUrl,
        );
        songs.add(songEntity);
      }

      print('🎉 Returning ${songs.length} songs with real data');
      return Right(songs);
    } catch (e) {
      print('💥 Error: $e');
      return Left('Error: $e');
    }
  }

  @override
  Future<Either> getAllCovers() async {
    try {
      final supabase = Supabase.instance.client;
      print('📡 Connecting to Supabase storage...');

      // Try to list all buckets first
      try {
        final buckets = await supabase.storage.listBuckets();
        print('🪣 Available buckets: ${buckets.map((b) => b.name).toList()}');

        for (var bucket in buckets) {
          print('🔍 Checking bucket: ${bucket.name}');
          try {
            final files = await supabase.storage.from(bucket.name).list();
            print('📁 ${bucket.name} has ${files.length} files');

            for (var file in files.take(3)) {
              // Show first 3 files
              print('   📄 ${file.name}');
            }
          } catch (e) {
            print('   ❌ Error accessing ${bucket.name}: $e');
          }
        }
      } catch (e) {
        print('❌ Error listing buckets: $e');
      }

      final response = await supabase.storage.from('covers').list();
      print('📦 Supabase response: ${response.length} files');

      List<Map<String, String>> covers = [];
      for (var file in response) {
        String fileName = file.name;
        String publicUrl = supabase.storage
            .from('covers')
            .getPublicUrl(fileName);

        covers.add({'name': fileName, 'url': publicUrl});
        print('📸 File: $fileName -> $publicUrl');
      }

      return Right(covers);
    } catch (e) {
      print('Failed to get covers: $e');
      return Left('Failed to get cover: $e');
    }
  }

  @override
  @override
  Future<Either<dynamic, dynamic>> getPlaylist() async {
    try {
      List<SongEntity> songs = [];

      // Get covers from Supabase
      print('🔍 Fetching covers from Supabase...');
      var coversResult = await getAllCovers();
      Map<String, String> coverUrls = {};

      coversResult.fold((error) => print('❌ Error getting covers: $error'), (
        covers,
      ) {
        for (var cover in covers) {
          String fileName = cover['name'];
          String songName = fileName
              .replaceAll('.jpg', '')
              .replaceAll('.png', '')
              .replaceAll('.jpeg', '');
          coverUrls[songName] = cover['url'];
        }
      });

      // Get songs from Firebase
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songData = element.data();

        String title = songData['title'] ?? '';
        String artist = songData['artist'] ?? '';

        // Handle duration conversion properly
        dynamic durationField = songData['duration'];
        num durationSeconds;

        if (durationField is String) {
          double minutes = double.tryParse(durationField) ?? 3.0;
          durationSeconds = (minutes * 60).round();
        } else if (durationField is num) {
          durationSeconds = durationField;
        } else {
          durationSeconds = 180;
        }

        Timestamp releaseDate = songData['releaseDate'] ?? Timestamp.now();

        // Match cover URL
        String searchKey = '$artist , $title';
        String coverUrl = coverUrls[searchKey] ?? '';

        var songEntity = SongEntity(
          title: title,
          artist: artist,
          duration: durationSeconds,
          releaseData: releaseDate,
          coverUrl: coverUrl,
        );
        songs.add(songEntity);
      }

      print('🎉 Returning ${songs.length} playlist songs');
      return Right(songs);
    } catch (e) {
      print('💥 Error in getPlaylist: $e');
      return Left('Error: $e');
    }
  }
}
