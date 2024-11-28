import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/model/player.dart';
import 'package:projeto_final/view/screens/configuration_screen.dart';
import 'package:projeto_final/view/screens/game_screen.dart';
import 'package:projeto_final/view/screens/info_screen.dart';
import 'package:projeto_final/view/screens/initial_screen.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/navigation_bloc.dart';
import '../widgets/static_background.dart';
import 'screens/login_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/score_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const StaticBackground(),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Erro de Autenticação"),
                      content: Text(state.errorMessage),
                    );
                  },
                );
              } else if (state is AuthSuccess) {
                showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).pop();
                    });

                    return AlertDialog(
                      title: const Text("Sucesso na requisição"),
                      content: Text(state.successMessage),
                    );
                  },
                );
              } else if (state is Authenticated) {
                BlocProvider.of<NavigationBloc>(context).add(GoToMainMenu());
              } else if (state is Unauthenticated) {
                BlocProvider.of<NavigationBloc>(context).add(GoToInitial());
              }
            },
            child: BlocBuilder<NavigationBloc, NavigationState>(
              builder: (context, navigationState) {
                switch (navigationState) {
                  case InitialScreenState():
                    return const InitialScreen();
                  case LoginScreenState():
                    return LoginScreen();
                  case RegisterScreenState():
                    return RegisterScreen();
                  case MainMenuScreenState():
                    return const MainMenuScreen();
                  case ProfileScreenState():
                    return const ProfileScreen();
                  case ScoreScreenState():
                    return ScoreScreen();
                  case ConfigurationScreenState():
                    return const ConfigurationScreen();
                  case InfoScreenState():
                    return const InfoScreen();
                  case GameScreenState():
                    return const GameScreen();
                  default:
                    return const InitialScreen();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
