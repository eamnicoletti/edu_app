import 'package:edu_app/core/errors/exceptions.dart';
import 'package:edu_app/src/on_boarding/data/datasource/on_boarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSrcImp(prefs);
  });

  group('cacheFirstTimer', () {
    test('should call [SharedPreferences] to cache the data', () async {
      // arrange
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

      // act
      await localDataSource.cacheFirstTimer();

      // assert
      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw a [CacheException] when there is an error caching the data',
        () async {
      // arrange
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());

      // act
      final methodCall = localDataSource.cacheFirstTimer;

      // assert
      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfUserIsFirstTimer', () {});
}
