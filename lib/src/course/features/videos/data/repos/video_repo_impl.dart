import 'package:dartz/dartz.dart';
import 'package:edu_app/core/errors/exceptions.dart';
import 'package:edu_app/core/errors/failures.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/course/features/videos/data/datasources/video_remote_data_src.dart';
import 'package:edu_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:edu_app/src/course/features/videos/domain/repos/video_repo.dart';

class VideoRepoImpl implements VideoRepo {
  const VideoRepoImpl(this._remoteDataSrc);

  final VideoRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> addVideo(VideoEntity video) async {
    try {
      await _remoteDataSrc.addVideo(video);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<VideoEntity>> getVideos(String courseId) async {
    try {
      final result = await _remoteDataSrc.getVideos(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
