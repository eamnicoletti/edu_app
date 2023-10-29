import 'package:dartz/dartz.dart';
import 'package:edu_app/src/auth/domain/entities/user_entity.dart';
import 'package:edu_app/src/auth/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late SignInUsecase usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignInUsecase(repo);
  });

  const tUser = UserEntity.empty();

  test('should return [UserEntity] from the [AuthRepo]', () async {
    // arrange
    when(
      () => repo.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(
      const SignInParams(
        email: tEmail,
        password: tPassword,
      ),
    );

    // assert
    expect(result, const Right<dynamic, UserEntity>(tUser));
    verify(() => repo.signIn(email: tEmail, password: tPassword)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
