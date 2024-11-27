import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/constants/colors_constants.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import 'package:projeto_final/widgets/main_title.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 75),
          const MainTitle(),
          const SizedBox(height: 150),
          CustomSquare(
            borderRadius: 20,
            height: 70,
            width: 300,
            padding: 20,
            onTap: () =>
                BlocProvider.of<NavigationBloc>(context).add(GoToLogin()),
            children: const [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Login com e-mail",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(ColorsConstants.text)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomSquare(
            borderRadius: 20,
            height: 70,
            width: 300,
            padding: 20,
            onTap: () =>
                BlocProvider.of<NavigationBloc>(context).add(GoToRegister()),
            children: const [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Crie sua conta",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(ColorsConstants.text)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomSquare(
            padding: 20,
            width: 100,
            height: 70,
            borderRadius: 20,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text(
                      "Erro de serviço",
                      style: TextStyle(color: Color(ColorsConstants.text)),
                    ),
                    content: Text("Serviço em construção"),
                  );
                },
              );
            },
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/google_logo.png',
                  width: 26,
                  height: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
