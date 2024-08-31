import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../di_container.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/user/fetch_users_usecase.dart';

class UsersPageVM extends ChangeNotifier {
  final int _size = 2;
  int _page = 0;
  bool _isLast = false;
  bool get isLast => _isLast;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final List<UserEntity> _users = [];
  List<UserEntity> get users => _users;

  void clear() {
    _page = 0;
    _isLast = false;
    _isLoading = false;
    _users.clear();
    notifyListeners();
  }

  Future<void> fetch(BuildContext context) async {
    isLoading = true;

    final users = await DIContainer().get<FetchUsersUseCase>().fetch(
          context,
          page: _page,
          size: _size,
        );
    _isLast = !users['hasNext'];
    _users.addAll(users['contents']);

    isLoading = false;
  }

  Future<void> fetchMore(BuildContext context) async {
    if (isLoading || _isLast) return;
    _page++;
    await fetch(context);
  }
}
