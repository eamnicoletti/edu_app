import 'package:edu_app/core/common/views/loading_view.dart';
import 'package:edu_app/core/common/widgets/gradient_background.dart';
import 'package:edu_app/core/res/colours.dart';
import 'package:edu_app/core/res/media_res.dart';
import 'package:edu_app/src/on_boarding/domain/entities/page_content_entity.dart';
import 'package:edu_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:edu_app/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    context.read<OnBoardingCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCached) {
              // TODO(User-Cached-Handler): Push to the appropriate screen
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimer ||
                state is CachingFirstTimer) {
              return const LoadingView();
            }
            return GradientBackground(
              image: MediaRes.onBoardingBackground,
              child: Stack(
                children: [
                  PageView(
                    controller: pageController,
                    children: const [
                      // page 0
                      OnBoardingBody(pageContent: PageContentEntity.first()),
                      // page 1
                      OnBoardingBody(pageContent: PageContentEntity.second()),
                      // page 2
                      OnBoardingBody(pageContent: PageContentEntity.third()),
                    ],
                  ),
                  Align(
                    alignment: const Alignment(0, .04),
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      onDotClicked: (index) {
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 40,
                        activeDotColor: Colours.primaryColour,
                        dotColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
