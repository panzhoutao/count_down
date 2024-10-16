import 'package:count_down/widgets/base_state.dart';
import 'package:count_down/widgets/page.dart';
import 'package:count_down/widgets/scaffold.dart';
import 'package:count_down/widgets/widget.dart';
import 'package:flutter/material.dart';

///
class SortAndTagPage extends StatefulWidget {
  const SortAndTagPage({super.key});

  @override
  State<SortAndTagPage> createState() => _SortAndTagPageState();
}

class _SortAndTagPageState extends BaseState<SortAndTagPage> {
  @override
  Widget build(BuildContext context) {
    return ClosePage(
      child: MyScaffold(
        appBar: WidgetExtends.appBar(
          title: '分类与标签',
        ),
        body: () {
          return Container(
            child: Column(
              children: [],
            ),
          );
        },
      ),
    );
  }
}
