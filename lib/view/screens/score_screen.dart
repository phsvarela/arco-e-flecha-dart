import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import '../../widgets/header.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  final List<Map<String, dynamic>> rankings = const [
    {"name": "Melhor Arqueiro da História", "score": 100},
    {"name": "Arqueiro Master", "score": 90},
    {"name": "Arqueiro Senior", "score": 80},
    {"name": "Arqueiro Pleno", "score": 70},
    {"name": "Arqueiro Junior", "score": 60},
    {"name": "Arqueiro Estagiario", "score": 50},
    {"name": "Arqueiro Astuto", "score": 40},
    {"name": "Arqueiro Iniciante", "score": 30},
    {"name": "Arremesador de Chinelos", "score": 20},
    {"name": "Você", "score": 10},
  ];

  final String currentUserName = "Você";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Header(
                title: "Pontuação",
                showBackButton: true,
                onBackPressed: () => BlocProvider.of<NavigationBloc>(context)
                    .add(GoToMainMenu()),
              ),
              const SizedBox(height: 50),
              CustomSquare(
                padding: 20,
                width: 500,
                height: 400,
                borderRadius: 20,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: rankings.length,
                          itemBuilder: (context, index) {
                            final rankingItem = rankings[index];
                            final isCurrentUser =
                                rankingItem["name"] == currentUserName;

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isCurrentUser
                                      ? Colors.blue
                                      : Colors.transparent),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${index + 1}. ${rankings[index]["name"]}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    '${rankings[index]["score"]} pts',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
