import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entites/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseData;
  String? coverUrl;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseData,
    this.coverUrl,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'] is String
        ? double.tryParse(data['duration']) ?? 0.0
        : data['duration'];
    releaseData = data['releaseData'];
    coverUrl = data['coverUrl'] ?? '';
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseData: releaseData!,
      coverUrl: coverUrl ?? '',
    );
  }
}
