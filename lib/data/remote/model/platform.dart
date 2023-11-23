class Platform {
  int id;
  String name;
  String slug;

  Platform.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        slug = map["slug"];
}
