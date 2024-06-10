import 'package:edu_app/src/course/features/videos/data/models/video_model.dart';
import 'package:edu_app/src/course/features/videos/domain/entities/video_entity.dart';

abstract class VideoRemoteDataSrc {
  Future<List<VideoModel>> getVideos(String courseId);

  Future<void> addVideo(VideoEntity video);
}
