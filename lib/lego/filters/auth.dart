import 'package:firebase_auth/firebase_auth.dart';

import 'filters.dart';

class Authentication extends LegoFilter {
  static const type = 'authentication';
  final bool authenticated;

  Authentication.fromJson(Map<String, dynamic> json)
      : authenticated = json['authentication'] ?? true;

  @override
  bool display() {
    final isAuthenticated = FirebaseAuth.instance.currentUser != null;
    return isAuthenticated == authenticated;
  }
}
