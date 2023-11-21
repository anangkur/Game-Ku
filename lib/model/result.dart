import 'package:gameku/model/game.dart';

class Result {
  List<Game> games;

  Result.fromJsonMap(Map<String, dynamic> map): games = List<Game>.from(
    map["results"].map((it) => Game.fromJsonMap(it))
  );
}
