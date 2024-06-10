import 'package:edu_app/core/common/app/providers/user_provider.dart';
import 'package:edu_app/core/extensions/context_extension.dart';
import 'package:edu_app/src/home/presentation/widgets/tinder_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height;

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Text(
            'Hello,\n${context.watch<UserProvider>().user!.fullName}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          Positioned(
            top: height >= 926
                ? -25
                : height >= 844
                    ? -6
                    : height <= 800
                        ? 10
                        : 10,
            right: -14,
            child: const TinderCards(),
          ),
        ],
      ),
    );
  }
}
