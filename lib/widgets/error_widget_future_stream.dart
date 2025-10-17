import 'package:flutter/material.dart';
import 'package:musit/constants/colors.dart';

import '../constants/text_styles.dart';

class ErrorWidgetFutureStream extends StatelessWidget {
  const ErrorWidgetFutureStream({
    super.key,
    this.error,
  });

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: error == null
          ? CircularProgressIndicator(
              color: blackColor,
            )
          : Text(
              error ?? 'Something went wrong',
              style: manRope,
            ),
    );
  }
}
