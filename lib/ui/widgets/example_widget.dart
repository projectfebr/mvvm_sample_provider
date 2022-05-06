import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel extends ChangeNotifier {
  var _age = 0;
  int get age => _age;

  void loadValue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _age = sharedPreferences.getInt('age') ?? 0;
    notifyListeners();
  }

  ViewModel() {
    loadValue();
  }

  Future<void> incrementAge() async {
    _age += 1;
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('age', _age);
    notifyListeners();
  }

  Future<void> decrementAge() async {
    _age = max(_age - 1, 0);
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('age', _age);
    notifyListeners();
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${viewModel.age}'),
              ElevatedButton(
                onPressed: viewModel.incrementAge,
                child: const Text('+'),
              ),
              ElevatedButton(
                onPressed: viewModel.decrementAge,
                child: const Text('-'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
