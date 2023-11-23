class DetailGameResponse {
  String description;

  DetailGameResponse.fromJsonMap(Map<String, dynamic> map)
      : description = map["description_raw"];
}
