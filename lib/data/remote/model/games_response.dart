import 'package:gameku/data/remote/model/game_response.dart';

class GamesResponse {
  List<GameResponse> games;

  GamesResponse.fromJsonMap(Map<String, dynamic> map): games = List<GameResponse>.from(
    map["results"].map((it) => GameResponse.fromJsonMap(it))
  );
}
