import 'package:edu_app/core/usecases/usecases.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/auth/domain/entities/local_user_entity.dart';
import 'package:edu_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignInUsecase extends UsecaseWithParams<LocalUserEntity, SignInParams> {
  const SignInUsecase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<LocalUserEntity> call(SignInParams params) => _repo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : email = '',
        password = '';

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
