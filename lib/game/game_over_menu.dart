import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/game/archery_game.dart';
import 'package:projeto_final/widgets/custom_square.dart';

class GameOverMenu extends StatelessWidget {
  final ArcheryGame game;
  final int score;
  const GameOverMenu({super.key, required this.game, required this.score});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              CustomSquare(
                  padding: 20,
                  width: 450,
                  height: 300,
                  borderRadius: 20,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Center(
                            child: Text('Fim de Jogo',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400))),
                        Center(
                            child: Text('Pontos finais: $score',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400))),
                        Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomSquare(
                                    padding: 20,
                                    width: 180,
                                    height: 70,
                                    borderRadius: 20,
                                    onTap: () {
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(HandleGameOver(score: score));
                                      game.overlays.remove('GameOverMenu');
                                      game.reset();
                                    },
                                    children: const [
                                      Center(
                                        child: Text('Jogar Novamente'),
                                      )
                                    ],
                                  ),
                                  CustomSquare(
                                      padding: 20,
                                      width: 180,
                                      height: 70,
                                      borderRadius: 20,
                                      onTap: () {
                                        BlocProvider.of<NavigationBloc>(context)
                                            .add(HandleGameOver(score: score));
                                        game.overlays.remove('GameOverMenu');
                                        BlocProvider.of<NavigationBloc>(context)
                                            .add(GoToMainMenu());
                                      },
                                      children: const [
                                        Center(
                                          child: Text('Sair do Jogo'),
                                        )
                                      ])
                                ]),
                          ],
                        )
                      ],
                    )
                  ])
            ],
          ),
        )
      ],
    );
  }
}
