import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/course/features/videos/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  const VideoModel({
    required super.id,
    required super.videoURL,
    required super.courseId,
    required super.uploadDate,
    super.thumbnailIsFile = false,
    super.thumbnail,
    super.title,
    super.tutor,
  });

  VideoModel.empty()
      : this(
          id: '_empty.id',
          videoURL: '_empty.videoURL',
          uploadDate: DateTime.now(),
          courseId: '_empty.courseId',
        );

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      thumbnail: map['thumbnail'] as String?,
      videoURL: map['videoURL'] as String,
      title: map['title'] as String?,
      tutor: map['tutor'] as String?,
      courseId: map['courseId'] as String,
      uploadDate: (map['uploadDate'] as Timestamp).toDate(),
    );
  }

  VideoModel copyWith({
    String? id,
    String? thumbnail,
    String? videoURL,
    String? title,
    String? tutor,
    String? courseId,
    DateTime? uploadDate,
    bool? thumbnailIsFile,
  }) {
    return VideoModel(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      videoURL: videoURL ?? this.videoURL,
      title: title ?? this.title,
      tutor: tutor ?? this.tutor,
      courseId: courseId ?? this.courseId,
      uploadDate: uploadDate ?? this.uploadDate,
      thumbnailIsFile: thumbnailIsFile ?? this.thumbnailIsFile,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'tutor': tutor,
      'courseId': courseId,
      'thumbnail': thumbnail,
      'videoURL': videoURL,
      'uploadDate': FieldValue.serverTimestamp(),
    };
  }
}
