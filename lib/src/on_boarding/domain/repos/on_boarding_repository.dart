import 'package:edu_app/core/utils/typedfs.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();

  ResultFuture<void> cacheFirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
