import 'package:edu_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        try {
          context.pop();
          return;
        } catch (_) {
          Navigator.of(context).pop();
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
