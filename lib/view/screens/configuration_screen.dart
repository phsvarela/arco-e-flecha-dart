import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import '../../blocs/auth_bloc.dart';
import '../../widgets/header.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  bool isSoundOn = true;
  bool isWindOn = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 70),
            Header(
              title: "Configuração",
              showBackButton: true,
              onBackPressed: () =>
                  BlocProvider.of<NavigationBloc>(context).add(GoToMainMenu()),
            ),
            const SizedBox(height: 150),
            CustomSquare(
              padding: 20,
              width: 450,
              height: 300,
              borderRadius: 20,
              children: [
                Column(
                  children: [
                    SwitchListTile(
                      title: const Text("Som"),
                      value: isSoundOn,
                      onChanged: (bool value) {
                        setState(() {
                          isSoundOn = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SwitchListTile(
                      title: const Text("Vento"),
                      value: isWindOn,
                      onChanged: (bool value) {
                        setState(() {
                          isWindOn = value;
                        });
                      },
                    ),
                    const SizedBox(height: 70),
                    CustomSquare(
                      padding: 20,
                      width: 200,
                      height: 70,
                      borderRadius: 20,
                      onTap: () {
                        BlocProvider.of<NavigationBloc>(context)
                            .add(GoToProfile());
                      },
                      children: const [
                        Center(
                          child: Text(
                            "Sua conta",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSquare(
                    padding: 20,
                    width: 200,
                    height: 70,
                    borderRadius: 20,
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context).add(GoToInfo());
                    },
                    children: const [
                      Center(
                        child: Text(
                          "Como jogar",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  CustomSquare(
                    padding: 20,
                    width: 200,
                    height: 70,
                    borderRadius: 20,
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(Logout());
                    },
                    children: const [
                      Center(
                        child: Text(
                          "Sair",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
