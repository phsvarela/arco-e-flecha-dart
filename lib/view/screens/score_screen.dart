import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/model/player.dart';
import 'package:projeto_final/provider/firestore_provider.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import '../../widgets/header.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Player>>(
        future: FirestoreDatabase.helper.getAllPlayers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Jogador não encontrado!'));
          }

          final String currentUserName = "Você";

          List<Player> players = snapshot.data!;

          players.sort((a, b) => b.pontos.compareTo(a.pontos));

          return Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Header(
                      title: "Pontuação",
                      showBackButton: true,
                      onBackPressed: () =>
                          BlocProvider.of<NavigationBloc>(context)
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
                                itemCount: players.length,
                                itemBuilder: (context, index) {
                                  final rankingItem = players[index];
                                  final isCurrentUser = rankingItem.uid ==
                                      FirestoreDatabase.helper.uid;

                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                        color: isCurrentUser
                                            ? Colors.blue
                                            : Colors.transparent),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${index + 1}. ${isCurrentUser ? "Você" : rankingItem.username}',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          '${rankingItem.pontos} pts',
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
        });
  }
}
