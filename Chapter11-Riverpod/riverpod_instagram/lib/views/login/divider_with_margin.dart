import 'package:flutter/material.dart';

class DividerWithMargin extends StatelessWidget {
  const DividerWithMargin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Divider(),
    );
  }
}
