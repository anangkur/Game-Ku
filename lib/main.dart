import 'package:flutter/material.dart';
import 'package:gameku/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  final list = [
    Game(
      58781,
      "the-elder-scrolls-vi",
      "The Elder Scrolls VI",
      "https://media.rawg.io/media/games/b40/b40eba32d8715d5fdf9634939fe0eca3.jpg",
      5.0,
      6,
    ),
    Game(
      55161,
      "volfied-1989",
      "Volfied (1989)",
      "https://media.rawg.io/media/screenshots/ded/ded4b73ca6523c19fcd08690be401d49.jpg",
      4.83,
      6,
    ),
    Game(
      43252,
      "the-witcher-3-wild-hunt-blood-and-wine",
      "The Witcher 3: Wild Hunt – Blood and Wine",
      "https://media.rawg.io/media/games/b51/b51c3649322ac0de9dfbe83435eda449.jpg",
      4.81,
      554,
    ),
    Game(
      257255,
      "the-witcher-3-game-of-the-year",
      "The Witcher 3: Game of the Year",
      "https://media.rawg.io/media/screenshots/6e1/6e13d9acb4e7a6e184f24892f52c4544.jpg",
      4.78,
      674,
    ),
    Game(
      4167,
      "mass-effect-trilogy",
      "Mass Effect Trilogy",
      "https://media.rawg.io/media/games/036/036b0631f855ec96a4a2065511635116.jpg",
      4.75,
      129,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.builder(
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () {},
            child: Text(item.name),
          );
        },
        itemCount: list.length,
      )),
    );
  }
}
