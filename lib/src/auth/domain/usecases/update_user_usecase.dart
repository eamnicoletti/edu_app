import 'package:edu_app/core/enums/update_user.dart';
import 'package:edu_app/core/usecases/usecases.dart';
import 'package:edu_app/core/utils/typedfs.dart';
import 'package:edu_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUsecase extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUserUsecase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.empty()
      : this(action: UpdateUserAction.displayName, userData: '');

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
