import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:recipe_app/screens/home_screen.dart';

class AuthProvider with ChangeNotifier {
  String name = '';
  bool isLoading = false;

  void auth(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final facebookResult = await FacebookAuth.instance.login();
      if (facebookResult.accessToken == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      final userData = await FacebookAuth.instance.getUserData();
      final facebookCredential =
          FacebookAuthProvider.credential(facebookResult.accessToken!.token);
      final credential =
          await FirebaseAuth.instance.signInWithCredential(facebookCredential);
      name = userData['name'];
      notifyListeners();
      if (credential.user != null) {
        Future.delayed(const Duration(seconds: 0)).then((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.message!,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }
    isLoading = false;
    notifyListeners();
  }

  void fetchUserName() async {
    final currentUser = FirebaseAuth.instance.currentUser!.displayName;
    name = currentUser!;
    notifyListeners();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
