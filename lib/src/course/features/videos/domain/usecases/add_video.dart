import 'package:edu_app/core/usecases/usecases.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:edu_app/src/course/features/videos/domain/repos/video_repo.dart';

/// A use case responsible for adding a new video to the repository.
class AddVideo extends UsecaseWithParams<void, VideoEntity> {
  /// Creates an instance of [AddVideo] with the provided video repository.
  ///
  /// - [repo]: The video repository where the video will be added.
  const AddVideo(this._repo);

  final VideoRepo _repo;

  @override
  ResultFuture<void> call(VideoEntity params) => _repo.addVideo(params);
}
