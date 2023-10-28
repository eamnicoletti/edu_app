import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:edu_app/core/errors/failures.dart';
import 'package:edu_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:edu_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer_usecase.dart';
import 'package:edu_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimerUsecase {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimerUsecase {}

void main() {
  late CacheFirstTimerUsecase cacheFirstTimerUseCase;
  late CheckIfUserIsFirstTimerUsecase checkIfUserIsFirstTimer;
  late OnBoardingCubit cubit;

  setUp(() {
    cacheFirstTimerUseCase = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    cubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimerUseCase,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });

  final tFailure = CacheFailure(
    message: 'Insufficient storage permission',
    statusCode: 4032,
  );

  test('initial state should be [OnBoardingInitial]', () {
    expect(cubit.state, const OnBoardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTImer, USerCached] when successful',
      build: () {
        when(() => cacheFirstTimerUseCase()).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const [
        CachingFirstTimer(),
        UserCached(),
      ],
      verify: (_) {
        verify(() => cacheFirstTimerUseCase()).called(1);
        verifyNoMoreInteractions(cacheFirstTimerUseCase);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, OnBoardingError] when unsuccessful',
      build: () {
        when(() => cacheFirstTimerUseCase()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => [
        const CachingFirstTimer(),
        OnBoardingError(tFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => cacheFirstTimerUseCase()).called(1);
        verifyNoMoreInteractions(cacheFirstTimerUseCase);
      },
    );
  });

  group('checkIfUsersIsFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus] '
      'when successful',
      build: () {
        when(() => checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => const Right(false),
        );

        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => [
        const CheckingIfUserIsFirstTimer(),
        const OnBoardingStatus(isFirstTimer: false),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus(true)] '
      'when unsuccessful',
      build: () {
        when(() => checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckingIfUserIsFirstTimer(),
        OnBoardingStatus(isFirstTimer: true),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );
  });
}
