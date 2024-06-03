import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:edu_app/core/enums/update_user.dart';
import 'package:edu_app/src/auth/domain/entities/local_user_entity.dart';
import 'package:edu_app/src/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:edu_app/src/auth/domain/usecases/sign_in_usecase.dart';
import 'package:edu_app/src/auth/domain/usecases/sign_up_usecase.dart';
import 'package:edu_app/src/auth/domain/usecases/update_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignInUsecase signIn,
    required SignUpUsecase signUp,
    required ForgotPasswordUsecase forgotPassword,
    required UpdateUserUsecase updateUser,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        super(const AuthInitialState()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoadingState());
    });
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }

  final SignInUsecase _signIn;
  final SignUpUsecase _signUp;
  final ForgotPasswordUsecase _forgotPassword;
  final UpdateUserUsecase _updateUser;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (user) => emit(SignedInState(user)),
    );
  }

  Future<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        fullName: event.name,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (user) => emit(const SignedUpState()),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPassword(event.email);

    result.fold(
      (failure) => emit(AuthErrorState(failure.message)),
      (_) => emit(const ForgotPasswordSentState()),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUser(
      UpdateUserParams(
        action: event.action,
        userData: event.userData,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(failure.errorMessage)),
      (user) => emit(const UserUpdatedState()),
    );
  }
}
