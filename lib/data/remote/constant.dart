const String baseUrl = "https://api.rawg.io/api";
const String apiKey = "e301db5382f94b18ae02f9560bf9367f";

String provideGameListEndpoint() {
  return "$baseUrl/games?key=$apiKey";
}

String provideGameDetailEndpoint(int gameId) {
  return "$baseUrl/games/$gameId?key=$apiKey";
}
