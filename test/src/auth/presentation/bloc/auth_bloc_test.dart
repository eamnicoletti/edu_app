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
}
