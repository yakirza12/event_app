

import 'package:eventapp/services/auth.dart';
import 'package:flutter/cupertino.dart';

import '../../locator.dart';
import '../user.dart';

class BaseModel extends ChangeNotifier {
  final AuthService _authenticationService =
  locator<AuthService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}