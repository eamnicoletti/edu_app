import 'package:edu_app/core/usecases/usecases.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/on_boarding/domain/repos/on_boarding_repository.dart';

class CheckIfUserIsFirstTimerUsecase extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimerUsecase(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
