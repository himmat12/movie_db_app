class LanguageConfigurationModel {
  LanguageConfigurationModel({
    required this.iso6391,
    required this.englishName,
    required this.name,
  });

  String iso6391;
  String englishName;
  String name;

  factory LanguageConfigurationModel.fromJson(Map<String, dynamic> json) =>
      LanguageConfigurationModel(
        iso6391: json["iso_639_1"],
        englishName: json["english_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "english_name": englishName,
        "name": name,
      };
}
