import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/provider/auth_provider.dart';
import 'package:recipe_app/screens/auth_screen.dart';
import 'package:recipe_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> _listener;
  @override
  void initState() {
    super.initState();
    _listener = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        Future.delayed(const Duration(seconds: 0)).then((_) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AuthScreen.routeName,
            (route) => false,
          );
        });
      } else {
        Future.delayed(const Duration(seconds: 0)).then((_) {
          Provider.of<AuthProvider>(context, listen: false).fetchUserName();
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _listener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Memuat...'),
      ),
    );
  }
}
