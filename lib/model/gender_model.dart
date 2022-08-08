class GenderModel {
  final String gender;
  final String? apiTitle;

  GenderModel({required this.gender, required this.apiTitle});
}

List<GenderModel> genderList = [
  GenderModel(gender: "Мужской", apiTitle: "male"),
  GenderModel(gender: "Женский", apiTitle: "female"),
];
