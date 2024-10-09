import 'package:count_down/router_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        Get.offAllNamed(RoutersManager.home);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
