import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/provider/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, data, _) => Stack(
        children: [
          Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Selamat Datang di Recipe App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: OutlinedButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .auth(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.facebook_rounded),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Login hanya dengan Facebook'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (data.isLoading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: Color.fromRGBO(46, 56, 57, 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
