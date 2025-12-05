import 'package:caffeine/features/auth/login/widgets/login_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: LoginBody()
        ),
      ),
    );
  }
}
