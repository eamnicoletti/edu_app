part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {
  const AuthInitialState();
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

final class SignedInState extends AuthState {
  const SignedInState(this.user);

  final LocalUserEntity user;

  @override
  List<Object> get props => [user];
}

class SignedUpState extends AuthState {
  const SignedUpState();
}

class ForgotPasswordSentState extends AuthState {
  const ForgotPasswordSentState();
}

class UserUpdatedState extends AuthState {
  const UserUpdatedState();
}

final class AuthErrorState extends AuthState {
  const AuthErrorState(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
