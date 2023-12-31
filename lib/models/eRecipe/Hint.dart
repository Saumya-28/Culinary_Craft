import 'Food.dart';
import 'Measure.dart';

class Hint {
  Food food;
  List<Measure> measures;

  Hint({
    required this.food,
    required this.measures,
  });

  factory Hint.fromJson(Map<String, dynamic> json) => Hint(
    food: Food.fromJson(json["food"]),
    measures: List<Measure>.from(json["measures"].map((x) => Measure.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "food": food.toJson(),
    "measures": List<dynamic>.from(measures.map((x) => x.toJson())),
  };
}