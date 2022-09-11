import 'dart:convert';

CarsModel carsFromJson(String str) => CarsModel.fromJson(json.decode(str));

String carsToJson(CarsModel data) => json.encode(data.toJson());

class CarsModel {
    CarsModel({
        required this.id,
        required this.name,
        required this.group,
        required this.list,
    });

    String id;
    String name;
    String group;
    Map<String, List<String>> list;

    factory CarsModel.fromJson(Map<String, dynamic> json) => CarsModel(
        id: json["id"],
        name: json["name"],
        group: json["group"],
        list: Map.from(json["list"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "group": group,
        "list": Map.from(list).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    };
}
