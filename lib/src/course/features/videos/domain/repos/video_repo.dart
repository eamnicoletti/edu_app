import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/course/features/videos/domain/entities/video_entity.dart';

abstract class VideoRepo {
  const VideoRepo();

  ResultFuture<List<VideoEntity>> getVideos(String courseId);

  ResultFuture<void> addVideo(VideoEntity video);
}
