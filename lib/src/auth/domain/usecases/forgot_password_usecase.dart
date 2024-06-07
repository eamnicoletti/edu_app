import 'package:edu_app/core/usecases/usecases.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/auth/domain/repos/auth_repo.dart';

class ForgotPasswordUsecase extends UsecaseWithParams<void, String> {
  const ForgotPasswordUsecase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
