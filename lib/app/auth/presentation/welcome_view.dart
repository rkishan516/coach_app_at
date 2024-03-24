import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shiksha_dhra/app/auth/presentation/google_sign_in_button_widget.dart';
import 'package:shiksha_dhra/app/common/presentation/logo_widget.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Logo(
                width: 300,
              ),
            ),
            Spacer(flex: 4),
            GoogleSignInButton(),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
