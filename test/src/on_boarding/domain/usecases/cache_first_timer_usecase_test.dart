import 'package:dartz/dartz.dart';
import 'package:edu_app/core/errors/failures.dart';
import 'package:edu_app/src/on_boarding/domain/repos/on_boarding_repository.dart';
import 'package:edu_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimerUsecase usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimerUsecase(repo);
  });

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer] '
    'and return the right data',
    () async {
      // arrange
      when(() => repo.cacheFirstTimer()).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Unknown Error Occurred', statusCode: 500),
        ),
      );

      // act
      final result = await usecase();

      // assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(message: 'Unknown Error Occurred', statusCode: 500),
          ),
        ),
      );
      verify(() => repo.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
