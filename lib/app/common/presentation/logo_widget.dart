import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logo extends ConsumerWidget {
  const Logo({super.key, this.width});
  final double? width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return Image.asset(
        'assets/images/splash.png',
        width: width,
      );
    }
    return Image.asset(
      'assets/images/logo.png',
      width: width,
    );
  }
}
