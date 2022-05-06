import 'package:flutter/material.dart';
import 'package:mvvm_sample_provider/domain/services/user_service.dart';
import 'package:provider/provider.dart';

class ViewModelState {
  final String ageTitle;

  const ViewModelState({
    required this.ageTitle,
  });
}

// ViewModel относится именно к этому экрану. _age может использоваться на разных экранах. Нужно создать класс который будет управлять _age. - Repository, Service
class ViewModel extends ChangeNotifier {
  final _userService = UserService();

  var _state = const ViewModelState(ageTitle: '');
  ViewModelState get state => _state;

  Future<void> loadValue() async {
    await _userService.initialize();
    _updateState();
  }

  ViewModel() {
    loadValue();
  }

  Future<void> onIncrementButtonPressed() async {
    _userService.incrementAge();
    _updateState();
  }

  Future<void> onDecrementButtonPressed() async {
    _userService.decrementAge();
    _updateState();
  }

  void _updateState() {
    final user = _userService.user;
    _state = ViewModelState(ageTitle: user.age.toString());
    notifyListeners();
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _AgeTitle(),
              _AgeIncrementWidget(),
              _DecIncrementWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgeTitle extends StatelessWidget {
  const _AgeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ageTitle = context.select((ViewModel vm) => vm.state.ageTitle);
    return Text(ageTitle);
  }
}

class _AgeIncrementWidget extends StatelessWidget {
  const _AgeIncrementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();

    return ElevatedButton(
      onPressed: viewModel.onIncrementButtonPressed,
      child: const Text('+'),
    );
  }
}

class _DecIncrementWidget extends StatelessWidget {
  const _DecIncrementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();

    return ElevatedButton(
      onPressed: viewModel.onDecrementButtonPressed,
      child: const Text('-'),
    );
  }
}
