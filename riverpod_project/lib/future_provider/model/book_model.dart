class BookModel {
  BookModel({
    required this.id,
    required this.name,
    required this.auther,
    required this.decription,
    required this.amazon,
  });

  int? id;
  String? name;
  String? auther;
  String? decription;
  String? amazon;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json["id"],
    name: json["name"],
    auther: json["auther"],
    decription: json["decription"],
    amazon: json["amazon"],
  );
}
