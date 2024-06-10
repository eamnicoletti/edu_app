import 'package:dartz/dartz.dart';
import 'package:edu_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:edu_app/src/course/features/videos/domain/repos/video_repo.dart';
import 'package:edu_app/src/course/features/videos/domain/usecases/get_videos.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'video_repo.mock.dart';

void main() {
  // Create mocks for dependencies
  late VideoRepo repo;
  late GetVideos usecase;

  // Set up the test environment
  setUp(() {
    repo = MockVideoRepo();
    usecase = GetVideos(repo);
  });

  // Create a sample empty Video instance
  final tVideo = VideoEntity.empty();

  test('should call [VideoRepo.addVideo]', () async {
    // Mock the behavior of [VideoRepo.getVideos]
    when(() => repo.getVideos(any())).thenAnswer((_) async => Right([tVideo]));

    // Execute the use case with a test ID
    final result = await usecase('testId');

    // Expect a result of type Right<dynamic, List<Video>>
    expect(result, isA<Right<dynamic, List<VideoEntity>>>());

    // Verify that [VideoRepo.getVideos] was called once with the test ID
    verify(() => repo.getVideos('testId')).called(1);

    // Verify that there are no more interactions with the repository
    verifyNoMoreInteractions(repo);
  });
}
