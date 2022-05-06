import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMidel extends ChangeNotifier {}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  var _value = 0;

  void loadValue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _value = sharedPreferences.getInt('age') ?? 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$_value'),
              ElevatedButton(
                onPressed: () async {
                  _value += 1;
                  final sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setInt('age', _value);
                  setState(() {});
                },
                child: const Text('+'),
              ),
              ElevatedButton(
                onPressed: () async {
                  _value = max(_value - 1, 0);
                  final sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setInt('age', _value);
                  setState(() {});
                },
                child: const Text('-'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
