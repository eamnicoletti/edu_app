import 'package:dartz/dartz.dart';
import 'package:edu_app/core/errors/exceptions.dart';
import 'package:edu_app/core/errors/failures.dart';
import 'package:edu_app/src/on_boarding/data/datasource/on_boarding_local_data_source.dart';
import 'package:edu_app/src/on_boarding/data/repos/on_boarding_repo_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImp repoImp;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSrc();
    repoImp = OnBoardingRepoImp(localDataSource);
  });

  group('cacheFirstTimer', () {
    test('should complete successfully when call to local source is successful',
        () async {
      // arrange
      when(() => localDataSource.cacheFirstTimer()).thenAnswer(
        (_) async => Future.value(),
      );

      // act
      final result = await repoImp.cacheFirstTimer();

      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => localDataSource.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  test('should return [CacheFailure] when call to local source is unsuccessful',
      () async {
    // arrange
    when(() => localDataSource.cacheFirstTimer()).thenThrow(
      const CacheException(message: 'Insufficient storage'),
    );

    // act
    final result = await repoImp.cacheFirstTimer();

    // assert
    expect(
      result,
      Left<CacheFailure, dynamic>(
        CacheFailure(message: 'Insufficient storage', statusCode: 500),
      ),
    );
    verify(() => localDataSource.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(localDataSource);
  });
}
