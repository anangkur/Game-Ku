import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gameku/model/detail.dart';
import 'package:gameku/model/game.dart';
import 'package:http/http.dart' as http;

class DetailGame extends StatelessWidget {
  final Game game;

  const DetailGame({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return DetailGamePage(game: game);
  }
}

class DetailGamePage extends StatefulWidget {
  final Game game;

  const DetailGamePage({super.key, required this.game});

  @override
  State<StatefulWidget> createState() {
    return DetailGamePageState();
  }
}

class DetailGamePageState extends State<DetailGamePage> {
  Future fetchData() async {
    final response = await http.get(Uri.parse(
      "https://api.rawg.io/api/games/${widget.game.id}?key=e301db5382f94b18ae02f9560bf9367f",
    ));
    if (response.statusCode == 200) {
      return DetailGameResponse.fromJsonMap(json.decode(response.body));
    } else {
      return Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.game.name),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  coverImage(widget.game.backgroundImage),
                  content(widget.game),
                  sectionScreenshot(widget.game.shortScreenshots),
                  sectionPlatform(widget.game.platforms),
                  sectionDescription((snapshot.data as DetailGameResponse).description),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const LinearProgressIndicator();
          }
        },
      )
    );
  }

  Widget sectionScreenshot(List<String> screenshots) {
    if (screenshots.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle("Screenshots"),
          sectionScreenshotList(screenshots),
        ],
      );
    } else {
      return const SizedBox(
        height: 100,
        child: Text("No Screenshot available"),
      );
    }
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget sectionScreenshotList(List<String> screenshots) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Image.network(
              screenshots[index],
              fit: BoxFit.cover,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: screenshots.length,
      ),
    );
  }

  Widget coverImage(String image) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Image.network(
        widget.game.backgroundImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget content(Game game) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          contentTitle(game.name),
          contentRating(game.rating, game.ratingCount),
        ],
      ),
    );
  }

  Widget contentTitle(String title) {
    return Text(
      widget.game.name,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget contentRating(double rating, int ratingCount) {
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

  Widget sectionPlatform(List<String> platforms) {
    if (platforms.isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("Platform"),
              sectionPlatformList(platforms),
            ],
          ));
    } else {
      return const SizedBox(
        height: 100,
        child: Text("No Platform available"),
      );
    }
  }

  Widget sectionPlatformList(List<String> platforms) {
    return SizedBox(
      height: 54,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Chip(
              label: Text(platforms[index]),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: platforms.length,
      ),
    );
  }

  Widget sectionDescription(String description) {
    return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Description"),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(description),
            ),
          ],
        ));
  }
}
