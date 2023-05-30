import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class PostDateWidget extends StatelessWidget {
  final DateTime dateTime;

  const PostDateWidget({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMMM, yyyy, hh:mm a');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        formatter.format(dateTime),
      ),
    );
  }
}
