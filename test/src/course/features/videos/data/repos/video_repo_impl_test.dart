import 'package:dartz/dartz.dart';
import 'package:edu_app/core/errors/exceptions.dart';
import 'package:edu_app/core/errors/failures.dart';
import 'package:edu_app/src/course/features/videos/data/datasources/video_remote_data_src.dart';
import 'package:edu_app/src/course/features/videos/data/models/video_model.dart';
import 'package:edu_app/src/course/features/videos/data/repos/video_repo_impl.dart';
import 'package:edu_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockVideoRemoteDataSrc extends Mock implements VideoRemoteDataSrc {}

void main() {
  late VideoRemoteDataSrc remoteDataSrc;
  late VideoRepoImpl repoImpl;

  final tVideo = VideoModel.empty();

  setUp(() {
    remoteDataSrc = MockVideoRemoteDataSrc();
    repoImpl = VideoRepoImpl(remoteDataSrc);

    registerFallbackValue(tVideo);
  });

  const tException = ServerException(
    message: 'message',
    statusCode: 'statusCode',
  );

  group('addVideo', () {
    test(
        'should complet successfully when call to remote source is '
        'successful', () async {
      // Arrange
      when(() => remoteDataSrc.addVideo(any())).thenAnswer(
        (_) async => Future.value(),
      );

      // Act
      final result = await repoImpl.addVideo(tVideo);

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => remoteDataSrc.addVideo(tVideo)).called(1);
      verifyNoMoreInteractions(remoteDataSrc);
    });

    test(
        'should return [ServerFailure] when call to remote source is '
        'unsuccessful', () async {
      // Arrange
      when(() => remoteDataSrc.addVideo(any())).thenThrow(tException);

      // Act
      final result = await repoImpl.addVideo(tVideo);

      // Assert
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tException),
          ),
        ),
      );
      verify(() => remoteDataSrc.addVideo(tVideo)).called(1);
      verifyNoMoreInteractions(remoteDataSrc);
    });
  });

  group('getVideos', () {
    test(
      'should complete successfully when call to remote source is successful',
      () async {
        when(() => remoteDataSrc.getVideos(any())).thenAnswer(
          (_) async => [tVideo],
        );

        final result = await repoImpl.getVideos('courseId');

        expect(result, isA<Right<dynamic, List<VideoEntity>>>());
        verify(() => remoteDataSrc.getVideos('courseId')).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSrc.getVideos(any())).thenThrow(tException);

        final result = await repoImpl.getVideos('courseId');

        expect(
          result,
          Left<Failure, void>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDataSrc.getVideos('courseId')).called(1);
        verifyNoMoreInteractions(remoteDataSrc);
      },
    );
  });
}
