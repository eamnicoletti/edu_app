import 'package:edu_app/core/extensions/context_extension.dart';
import 'package:edu_app/core/res/colours.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.context, {
    required this.text,
    this.style,
    super.key,
  });

  final BuildContext context;
  final String text;
  final TextStyle? style;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;
  late TextSpan textSpan;
  late TextPainter textPainter;

  @override
  void initState() {
    textSpan = TextSpan(text: widget.text);

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: expanded ? null : 2,
    )..layout(maxWidth: widget.context.width * .9);
    super.initState();
  }

  @override
  void dispose() {
    textPainter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultStyle = TextStyle(
      height: 1.8,
      fontSize: 16,
      color: Colours.neutralTextColour,
    );
    return Container(
      child: textPainter.didExceedMaxLines
          ? _buildExpandableText(
              defaultStyle,
            ) // Display expandable text if needed
          : Text(
              widget.text,
              style: widget.style ?? defaultStyle,
            ), // Display the full text
    );
  }

  /// Function to build expandable text with "Show more" / "Show less" button
  RichText _buildExpandableText(TextStyle defaultStyle) {
    return RichText(
      text: TextSpan(
        text: expanded
            ? widget.text // Show full text if expanded
            : '${widget.text.substring(0, _getTruncateIndex())}...', // Truncate
        // text
        style: widget.style ?? defaultStyle,
        children: [
          TextSpan(
            text: expanded ? ' show less' : ' more', // Toggle button text
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  expanded = !expanded; // Toggle expanded state
                });
              },
            style: const TextStyle(
              color: Colours.primaryColour,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Function to get the index at which text should be truncated
  int _getTruncateIndex() {
    return textPainter
        .getPositionForOffset(
          Offset(
            widget.context.width,
            widget.context.height,
          ),
        )
        .offset;
  }
}
