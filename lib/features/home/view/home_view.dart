import 'package:caffeine/features/home/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
                onTap: FocusScope.of(context).unfocus,
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: HomeBody())
        ),
      ),
    );
  }
  }