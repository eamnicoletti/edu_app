import 'package:dartz/dartz.dart';
import 'package:edu_app/src/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late ForgotPasswordUsecase usecase;

  const tEmail = 'Test email';

  setUp(() {
    repo = MockAuthRepo();
    usecase = ForgotPasswordUsecase(repo);
  });

  test('should complete successfuly when call the repo is successful',
      () async {
    // arrange
    when(() => repo.forgotPassword(any())).thenAnswer(
      (_) async => const Right(null),
    );

    // act
    final result = await usecase(tEmail);

    // assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repo.forgotPassword(tEmail)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
