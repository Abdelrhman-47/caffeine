import 'package:caffeine/features/auth/register/widgets/register_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(onTap: FocusScope.of(context).unfocus,
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          body: RegisterBody()
        ),
      ),
    );
  }
}
