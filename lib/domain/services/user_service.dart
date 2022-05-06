import 'dart:math';

import 'package:mvvm_sample_provider/domain/data_providers/user_data_provider.dart';
import 'package:mvvm_sample_provider/domain/entity/user.dart';

class UserService {
  final _userDataProvider = UserDataProvider();
  var _user = User(0);
  User get user => _user;

  Future<void> initialize() async {
    _user = await _userDataProvider.loadValue();
  }

  void incrementAge() {
    _user = user.copyWith(age: user.age + 1);
    _userDataProvider.saveValue(_user);
  }

  void decrementAge() {
    _user = user.copyWith(age: max(user.age - 1, 0));
    _userDataProvider.saveValue(_user);
  }
}
