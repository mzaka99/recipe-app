import 'package:flutter/material.dart';
import 'package:recipe_app/provider/auth_provider.dart';
import 'package:recipe_app/provider/recipe_provider.dart';
import 'package:recipe_app/screens/auth_screen.dart';
import 'package:recipe_app/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/recipe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      drawer: myDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              FutureBuilder(
                future: Provider.of<RecipeProvider>(context, listen: false)
                    .extractDataRecipe(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    return Consumer<RecipeProvider>(
                      builder: (context, data, _) => Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: data.recipes.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              top: index == 0 ? 0 : 15,
                            ),
                            child: RecipeCard(
                              dataRecipe: data.recipes[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Recipe App',
        style: TextStyle(
          fontSize: 20,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 1,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
            Navigator.of(context).restorablePushNamedAndRemoveUntil(
                AuthScreen.routeName, (route) => false);
          },
          icon: const Icon(Icons.logout_rounded),
        ),
      ],
    );
  }

  Drawer myDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade500,
              child: Icon(
                Icons.person,
                size: 35,
                color: Colors.grey.shade300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<AuthProvider>(builder: (context, data, _) {
              return Text(
                'Halo, ${data.name}',
                style: const TextStyle(fontSize: 17),
              );
            }),
          ],
        ),
      ),
    );
  }
}
