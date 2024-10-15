import 'package:count_down/router_manage.dart';
import 'package:flutter/material.dart';

/// 设置
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: ElevatedButton(
        onPressed: () {
          showCupertinoModalSheet(
            context: context,
            builder: (context) => SettingsPage(),
          );
        },
        child: Text('data'),
      ),
    );
  }
}
