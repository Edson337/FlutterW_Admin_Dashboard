import 'package:flutter/material.dart';

import '../api/CafeApi.dart';
import '../models/http/user.dart';
import '../models/http/users_response.dart';

class UsersProvider extends ChangeNotifier {
  List<User> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  UsersProvider() {
    getPaginatedUsers();
  }

  getPaginatedUsers() async {
    final response = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final userReponse = UsersResponse.fromMap(response);
    users = [...userReponse.usuarios];
    isLoading = false;
    notifyListeners();
  }

  Future<User?> getUserById(String uid) async {
    try {
      final response = await CafeApi.httpGet('/usuarios/$uid');
      final user = User.fromMap(response);
      return user;
    } catch (e) {
      print('Error fetching user with ID $uid: $e');
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(User user) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });
    ascending = !ascending;
    notifyListeners();
  }

  void refreshUser(User newUser) {
    users = users.map((user) {
      if (user.uid == newUser.uid) return newUser;
      return user;
    }).toList();
    notifyListeners();
  }
}