import 'package:dartz/dartz.dart';
import 'package:edu_app/src/auth/domain/entities/local_user_entity.dart';
import 'package:edu_app/src/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late SignUpUsecase usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tFullName = 'Test fullName';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignUpUsecase(repo);
  });

  const tUser = LocalUserEntity.empty();

  test('should return [LocalUserEntity] from the [AuthRepo]', () async {
    // arrange
    when(
      () => repo.signUp(
        email: any(named: 'email'),
        fullName: any(named: 'fullName'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(null));

    // act
    final result = await usecase(
      const SignUpParams(
        email: tEmail,
        password: tPassword,
        fullName: tFullName,
      ),
    );

    // assert
    expect(result, const Right<dynamic, LocalUserEntity>(tUser));
    verify(
      () => repo.signUp(
        email: tEmail,
        password: tPassword,
        fullName: tFullName,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
