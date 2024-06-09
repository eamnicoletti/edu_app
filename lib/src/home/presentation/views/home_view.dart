import 'package:edu_app/core/common/widgets/gradient_background.dart';
import 'package:edu_app/core/res/media_res.dart';
import 'package:edu_app/src/home/presentation/components/home_app_bar.dart';
import 'package:edu_app/src/home/presentation/components/home_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: HomeBody(),
      ),
    );
  }
}
