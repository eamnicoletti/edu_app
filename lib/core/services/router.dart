import 'package:edu_app/core/common/views/page_under_construction.dart';
import 'package:edu_app/core/services/injection_container.dart';
import 'package:edu_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:edu_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final result = switch (settings.name) {
    OnBoardingScreen.routeName => _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings: settings,
      ),
    _ => _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      ),
  };

  return result;
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(
      context,
    ),
  );
}
