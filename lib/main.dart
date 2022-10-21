import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/provider/auth_provider.dart';
import 'package:recipe_app/provider/recipe_provider.dart';
import 'package:recipe_app/screens/auth_screen.dart';
import 'package:recipe_app/screens/home_screen.dart';
import 'package:recipe_app/screens/recipe_detail.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => RecipeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Recipe App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AuthScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          AuthScreen.routeName: (context) => const AuthScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          RecipeDetail.routeName: (context) => const RecipeDetail(),
        },
      ),
    );
  }
}
