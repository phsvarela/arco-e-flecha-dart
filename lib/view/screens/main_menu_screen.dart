import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import 'package:projeto_final/widgets/header.dart';
import '../../blocs/navigation_bloc.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          const Header(title: "Menu Principal", isMainMenu: true),
          const SizedBox(
            height: 200,
          ),
          CustomSquare(
              padding: 20,
              width: 300,
              height: 90,
              borderRadius: 20,
              onTap: () {
                BlocProvider.of<NavigationBloc>(context).add(GoToGameScreen());
              },
              children: const [
                Center(
                  child: Text(
                    "Jogar",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ]),
          const SizedBox(
            height: 30,
          ),
          CustomSquare(
              padding: 20,
              width: 200,
              height: 70,
              borderRadius: 20,
              onTap: () {
                BlocProvider.of<NavigationBloc>(context).add(GoToScore());
              },
              children: const [
                Center(
                  child: Text(
                    "Pontuação",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                )
              ])
        ],
      ),
    );
  }
}
