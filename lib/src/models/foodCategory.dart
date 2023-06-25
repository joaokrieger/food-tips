class FoodCategory {
  final int id;
  final String description;

  FoodCategory({
    required this.id,
    required this.description,
  });

  String get getDescription => description;
}
