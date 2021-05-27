class CountryConfigurationModel {
  CountryConfigurationModel({
    this.iso31661,
    this.englishName,
    this.nativeName,
  });

  String? iso31661;
  String? englishName;
  String? nativeName;

  factory CountryConfigurationModel.fromJson(Map<String, dynamic> json) =>
      CountryConfigurationModel(
        iso31661: json["iso_3166_1"],
        englishName: json["english_name"],
        nativeName: json["native_name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "english_name": englishName,
        "native_name": nativeName,
      };
}
