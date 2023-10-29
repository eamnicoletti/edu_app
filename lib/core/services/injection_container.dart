import 'package:edu_app/src/on_boarding/data/datasource/on_boarding_local_data_source.dart';
import 'package:edu_app/src/on_boarding/data/repos/on_boarding_repo_imp.dart';
import 'package:edu_app/src/on_boarding/domain/repos/on_boarding_repository.dart';
import 'package:edu_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:edu_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer_usecase.dart';
import 'package:edu_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  // Feature ==> OnBoarding
  // Business Logic
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimerUsecase(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimerUsecase(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImp(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImp(sl()),
    )
    ..registerLazySingleton(() => prefs);
}
