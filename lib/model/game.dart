class Game {
  int id;
  String slug;
  String name;
  String backgroundImage;
  double rating;
  int ratingCount;

  Game.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        slug = map["slug"],
        name = map["name"],
        backgroundImage = map["background_image"],
        rating = map["rating"],
        ratingCount = map["ratings_count"];
}