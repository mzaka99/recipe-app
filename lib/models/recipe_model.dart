class RecipeModel {
  final String title;
  final String thumb;
  final String key;
  final String times;
  final String serving;
  final String difficulty;

  RecipeModel(
      {required this.title,
      required this.thumb,
      required this.key,
      required this.times,
      required this.serving,
      required this.difficulty});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'],
      thumb: json['thumb'],
      key: json['key'],
      times: json['times'],
      serving: json['serving'],
      difficulty: json['difficulty'],
    );
  }
}

class RecipeModelDetail {
  final String desc;
  final Author author;
  final List<dynamic> needItem;
  final List<dynamic> ingredient;
  final List<dynamic> step;

  RecipeModelDetail({
    required this.desc,
    required this.author,
    required this.needItem,
    required this.ingredient,
    required this.step,
  });
}

class Author {
  final String user;
  final String datePublished;

  Author({required this.user, required this.datePublished});
}
