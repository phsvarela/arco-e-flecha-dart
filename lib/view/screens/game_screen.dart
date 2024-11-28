import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final/game/archery_game.dart';
import 'package:projeto_final/game/game_over_menu.dart';
import 'package:projeto_final/game/pause_menu.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: ArcheryGame(),
        overlayBuilderMap: {
          'PauseMenu': (context, ArcheryGame game) => PauseMenu(game: game),
          'GameOverMenu': (context, ArcheryGame game) =>
              GameOverMenu(game: game, score: (game.finalScore).toInt())
        },
      ),
    );
  }
}