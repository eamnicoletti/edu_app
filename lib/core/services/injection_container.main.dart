part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourse();
}

Future<void> _initCourse() async {
  sl
    ..registerFactory(
      () => CourseCubit(
        addCourse: sl(),
        getCourses: sl(),
      ),
    )
    ..registerLazySingleton(() => AddCourse(sl()))
    ..registerLazySingleton(() => GetCourses(sl()))
    ..registerLazySingleton<CourseRepo>(() => CourseRepoImpl(sl()))
    ..registerLazySingleton<CourseRemoteDataSrc>(
      () => CourseRemoteDataSrcImpl(
        firestore: sl(),
        storage: sl(),
        auth: sl(),
      ),
    );
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignInUsecase(sl()))
    ..registerLazySingleton(() => SignUpUsecase(sl()))
    ..registerLazySingleton(() => ForgotPasswordUsecase(sl()))
    ..registerLazySingleton(() => UpdateUserUsecase(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImp(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initOnBoarding() async {
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
