class Nutrients {
  double enercKcal;
  double procnt;
  double fat;
  double chocdf;
  double fibtg;

  Nutrients({
    required this.enercKcal,
    required this.procnt,
    required this.fat,
    required this.chocdf,
    required this.fibtg,
  });

  factory Nutrients.fromJson(Map<String, dynamic> json) => Nutrients(
    enercKcal: json["ENERC_KCAL"],
    procnt: json["PROCNT"]?.toDouble(),
    fat: json["FAT"]?.toDouble(),
    chocdf: json["CHOCDF"]?.toDouble(),
    fibtg: json["FIBTG"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "ENERC_KCAL": enercKcal,
    "PROCNT": procnt,
    "FAT": fat,
    "CHOCDF": chocdf,
    "FIBTG": fibtg,
  };
}
