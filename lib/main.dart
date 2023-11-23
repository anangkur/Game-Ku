import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gameku/data/remote/constant.dart';
import 'package:gameku/detail.dart';
import 'package:gameku/data/remote/model/game_response.dart';
import 'package:gameku/data/remote/model/games_response.dart';
import 'package:gameku/login.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gameku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Game Ku'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? username;

  Future fetchData() async {
    final response = await http.get(Uri.parse(provideGameListEndpoint()));
    if (response.statusCode == 200) {
      return GamesResponse.fromJsonMap(json.decode(response.body));
    } else {
      return Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: () {
              if (username != null) {
                logout();
              } else {
                goToLogin();
              }
            },
            child: buttonLogin(username),
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: gameGrid(snapshot.data));
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const LinearProgressIndicator();
          }
        },
      ),
    );
  }

  Widget buttonLogin(String? username) {
    if (username != null) {
      return Text(username);
    } else {
      return const Text("Login");
    }
  }

  Widget gameGrid(GamesResponse data) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final item = data.games[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return DetailGame(game: item);
              },
            ));
          },
          child: gameItem(item),
        );
      },
      itemCount: data.games.length,
    );
  }

  Widget gameItem(GameResponse game) {
    return SizedBox(
      height: double.infinity,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gameItemImage(game.backgroundImage),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gameItemRating(game.rating, game.ratingCount),
                  gameitemTitle(game.name),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget gameItemImage(String backgroundImage) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Image.network(
        backgroundImage,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget gameItemRating(double rating, int ratingCount) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.orange),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text("$rating ($ratingCount)"),
          ),
        ],
      ),
    );
  }

  Widget gameitemTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Future<void> goToLogin() async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const Login();
    }));
    if (result != null) {
      setState(() {
        username = result.toString();
      });
    }
  }

  void logout() {
    setState(() {
      username = null;
    });
  }
}
