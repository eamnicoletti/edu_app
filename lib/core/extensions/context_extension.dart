import 'package:edu_app/core/common/app/providers/course_of_the_day_notifier.dart';
import 'package:edu_app/core/common/app/providers/tab_navigator.dart';
import 'package:edu_app/core/common/app/providers/user_provider.dart';
import 'package:edu_app/src/auth/domain/entities/local_user_entity.dart';
import 'package:edu_app/src/course/domain/entities/course_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;

  UserProvider get userProvider => read<UserProvider>();

  LocalUserEntity? get currentUser => userProvider.user;

  TabNavigator get tabNavigator => read<TabNavigator>();

  CourseEntity? get courseOfTheDay =>
      read<CourseOfTheDayNotifier>().courseOfTheDay;

  void pop() => tabNavigator.pop();

  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
