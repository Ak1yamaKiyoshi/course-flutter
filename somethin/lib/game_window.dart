import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:somethin/game.dart';



class GameWindow extends StatelessWidget {
  const GameWindow({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: GameWidget(game: SpaceSomething()),
    );
  }
}