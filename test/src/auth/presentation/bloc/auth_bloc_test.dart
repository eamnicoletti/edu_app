import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:edu_app/core/errors/failures.dart';
import 'package:edu_app/src/auth/domain/entities/local_user_entity.dart';
import 'package:edu_app/src/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:edu_app/src/auth/domain/usecases/sign_in_usecase.dart';
import 'package:edu_app/src/auth/domain/usecases/sign_up_usecase.dart';
import 'package:edu_app/src/auth/domain/usecases/update_user_usecase.dart';
import 'package:edu_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignInUsecase {}

class MockSignUp extends Mock implements SignUpUsecase {}

class MockForgotPassword extends Mock implements ForgotPasswordUsecase {}

class MockUpdateUser extends Mock implements UpdateUserUsecase {}

void main() {
  late SignInUsecase signIn;
  late SignUpUsecase signUp;
  late ForgotPasswordUsecase forgotPassword;
  late UpdateUserUsecase updateUser;
  late AuthBloc authBloc;

  const tSignInParams = SignInParams.empty();
  const tSignUpParams = SignUpParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tUpdateUserParams);
  });

  tearDown(() => authBloc.close());

  test('initialState should be [AuthInitialState]', () {
    expect(authBloc.state, const AuthInitialState());
  });

  final tServerFailure = ServerFailure(
    message: 'user-not-found',
    statusCode: 'There is no user record corresponding to this identifier. '
        'The user may have been deleted',
  );

  group('SignInEvent', () {
    const tUser = LocalUserEntity.empty();

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoadingState, SignInState] '
      'when signIn succeeds',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoadingState(),
        const SignedInState(tUser),
      ],
      verify: (_) {
        verify(() => signIn(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [authLoading, authError] when signIn fails',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSignInParams.email,
          password: tSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoadingState(),
        AuthErrorState(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => signIn(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });
}
