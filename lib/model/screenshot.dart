class Screenshot {
  int id;
  String image;

  Screenshot.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        image = map["image"];
}
