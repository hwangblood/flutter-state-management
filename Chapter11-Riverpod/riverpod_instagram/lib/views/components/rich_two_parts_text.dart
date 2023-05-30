import 'package:flutter/material.dart';

class RichTwoPartsText extends StatelessWidget {
  final String leftPart;
  final String rightPart;
  const RichTwoPartsText({
    super.key,
    required this.leftPart,
    required this.rightPart,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
              overflow: TextOverflow.ellipsis,
            ),
        children: [
          TextSpan(
            text: leftPart,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          // const TextSpan(
          //   text: '  ',
          // ),
          const WidgetSpan(
            child: SizedBox(width: 8),
          ),
          TextSpan(
            text: rightPart,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
