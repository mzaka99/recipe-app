import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/provider/recipe_provider.dart';
import 'package:provider/provider.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({super.key});

  static const routeName = '/recipe-detail';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    final dataRecipe =
        Provider.of<RecipeProvider>(context, listen: false).findByKey(args);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.black87,
              size: 30,
            ),
            onPressed: () {
              Navigator.maybePop(context);
            }),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: Provider.of<RecipeProvider>(context, listen: false)
            .extractDataRecipeDetail(dataRecipe.key),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Consumer<RecipeProvider>(
                  builder: (context, data, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(dataRecipe, data.recipeDetail!),
                      DefaultTabController(
                        initialIndex: 0,
                        length: 4,
                        child: Container(
                          height: 300,
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5.0,
                                offset: const Offset(0.0, 0.75),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: TabBar(
                                  labelPadding: EdgeInsets.zero,
                                  labelColor: Colors.black,
                                  labelStyle: TextStyle(fontSize: 12),
                                  unselectedLabelColor: Colors.black54,
                                  tabs: [
                                    Tab(
                                      text: 'Bumbu',
                                    ),
                                    Tab(
                                      text: 'Bahan',
                                    ),
                                    Tab(
                                      text: 'Step',
                                    ),
                                    Tab(
                                      text: 'Deskripsi',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    ListView.builder(
                                      itemCount:
                                          data.recipeDetail!.needItem.length,
                                      itemBuilder: (context, index) => SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.fiber_manual_record,
                                              size: 15,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(data
                                                .recipeDetail!.needItem[index]),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount:
                                          data.recipeDetail!.ingredient.length,
                                      itemBuilder: (context, index) => SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.fiber_manual_record,
                                              size: 15,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                data.recipeDetail!
                                                    .ingredient[index],
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount: data.recipeDetail!.step.length,
                                      itemBuilder: (context, index) => SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          data.recipeDetail!.step[index]
                                              .toString()
                                              .replaceFirstMapped(
                                                  (index + 1).toString(),
                                                  (match) => '${index + 1}.'),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Text(
                                        data.recipeDetail!.desc,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Column header(RecipeModel dataRecipe, RecipeModelDetail dataRecipeDetail) {
    return Column(
      children: [
        Image.network(
          dataRecipe.thumb,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataRecipe.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(dataRecipe.times),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(dataRecipe.difficulty),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.rice_bowl_rounded),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(dataRecipe.serving),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<RecipeProvider>(builder: (context, data, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Author : ${data.recipeDetail!.author.user}',
                    ),
                    Text(
                      'Publish : ${data.recipeDetail!.author.datePublished}',
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
