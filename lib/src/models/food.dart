class Food {
  final int id;
  final String description;
  final String calories;
  final String servingSize;
  final String totalFat;
  final String saturatedFat;
  final String cholesterol;
  final String sodium;
  final String carbohydrate;
  final String proteins;
  final int foodType;
  bool is_stared;

  Food({
    required this.id,
    required this.description,
    required this.calories,
    required this.servingSize,
    required this.totalFat,
    required this.saturatedFat,
    required this.cholesterol,
    required this.sodium,
    required this.carbohydrate,
    required this.proteins,
    required this.foodType,
    required this.is_stared
  });
}
