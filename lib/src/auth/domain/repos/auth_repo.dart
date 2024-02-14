import 'package:edu_app/core/enums/update_user.dart';
import 'package:edu_app/core/utils/typedfs.dart';
import 'package:edu_app/src/auth/domain/entities/local_user_entity.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<LocalUserEntity> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
