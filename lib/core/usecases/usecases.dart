import 'package:edu_app/core/utils/typedfs.dart';

abstract class UsecaseWithParams<Type, Params> {
  UsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  UsecaseWithoutParams();

  ResultFuture<Type> call();
}
