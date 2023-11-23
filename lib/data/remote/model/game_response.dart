import 'package:gameku/data/remote/model/platforms.dart';
import 'package:gameku/data/remote/model/screenshot.dart';

class GameResponse {
  int id;
  String slug;
  String name;
  String backgroundImage;
  double rating;
  int ratingCount;
  List<String> shortScreenshots;
  List<String> platforms;

  GameResponse.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        slug = map["slug"],
        name = map["name"],
        backgroundImage = map["background_image"],
        rating = map["rating"],
        ratingCount = map["ratings_count"],
        shortScreenshots = List<String>.from(map["short_screenshots"]
            .map((screenshot) => Screenshot.fromJsonMap(screenshot).image)),
        platforms = List<String>.from(map["platforms"].map((platforms) =>
            PlatformWrapper.fromJsonMap(platforms).platform.name));
}
