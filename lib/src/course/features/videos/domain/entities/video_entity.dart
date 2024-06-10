// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  const VideoEntity({
    required this.id,
    required this.videoURL,
    required this.courseId,
    required this.uploadDate,
    this.thumbnailIsFile = false,
    this.thumbnail,
    this.title,
    this.tutor,
  });

  VideoEntity.empty()
      : this(
          id: '_empty.id',
          videoURL: '_empty.videoURL',
          uploadDate: DateTime.now(),
          courseId: '_empty.courseId',
        );

  final String id;
  final String? thumbnail;
  final String videoURL;
  final String? title;
  final String? tutor;
  final String courseId;
  final DateTime uploadDate;
  final bool thumbnailIsFile;

  @override
  List<Object> get props => [id];
}
