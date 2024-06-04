import 'package:edu_app/core/res/colours.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.buttonColour,
    this.labelColour,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? buttonColour;
  final Color? labelColour;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour ?? Colours.primaryColour,
        foregroundColor: labelColour ?? Colors.white,
        minimumSize: const Size(double.maxFinite, 50),
      ),
      child: Text(label),
    );
  }
}
