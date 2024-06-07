import 'package:edu_app/core/usecases/usecases.dart';
import 'package:edu_app/core/utils/typedefs.dart';
import 'package:edu_app/src/on_boarding/domain/repos/on_boarding_repository.dart';

class CacheFirstTimerUsecase extends UsecaseWithoutParams<void> {
  const CacheFirstTimerUsecase(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFirstTimer();
}
