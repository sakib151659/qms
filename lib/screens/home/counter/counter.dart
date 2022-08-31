import 'package:flutter/material.dart';

import '../../../components/appbar/appbar.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.getAppBar(context, "Counter Panel"),
    );
  }
}
