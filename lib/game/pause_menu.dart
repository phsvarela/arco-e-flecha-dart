import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/game/archery_game.dart';
import 'package:projeto_final/widgets/custom_square.dart';

class PauseMenu extends StatelessWidget {
  final ArcheryGame game;
  const PauseMenu({super.key, required this.game});

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
                            child: Text('Jogo Pausado',
                                style: TextStyle(
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
                                      game.overlays.remove('PauseMenu');
                                      game.resumeEngine();
                                    },
                                    children: const [
                                      Center(
                                        child: Text('Continuar'),
                                      )
                                    ],
                                  ),
                                  CustomSquare(
                                      padding: 20,
                                      width: 180,
                                      height: 70,
                                      borderRadius: 20,
                                      onTap: () {
                                        game.overlays.remove('PauseMenu');
                                        game.reset();
                                      },
                                      children: const [
                                        Center(
                                          child: Text('Reiniciar'),
                                        )
                                      ])
                                ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: CustomSquare(
                                  padding: 20,
                                  width: 180,
                                  height: 70,
                                  borderRadius: 20,
                                  onTap: () {
                                    game.overlays.remove('PauseMenu');
                                    BlocProvider.of<NavigationBloc>(context)
                                        .add(GoToMainMenu());
                                  },
                                  children: const [
                                    Center(
                                      child: Text('Sair do Jogo'),
                                    )
                                  ]),
                            ),
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
