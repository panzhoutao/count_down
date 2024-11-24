import 'package:count_down/pages/home/home.dart';
import 'package:count_down/services/countdown_service.dart';
import 'package:count_down/widgets/cupertino_modal_sheet_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/tag_service.dart';

///
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Get.put(TagService());
    Get.put(CountdownService());

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        Navigator.of(context).push(
          CupertinoModalSheetRoute(
            builder: ((context) => HomePage()),
            isFullScreen: true,
          ),
          // (route) => false,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
