import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import '../../widgets/header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              Header(
                  title: "Sua conta",
                  showBackButton: true,
                  onBackPressed: () => BlocProvider.of<NavigationBloc>(context)
                      .add(GoToConfiguration())),
              const SizedBox(
                height: 150,
              ),
              const CustomSquare(
                  padding: 20,
                  width: 450,
                  height: 400,
                  borderRadius: 20,
                  children: [
                    Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Você",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("E-mail:"),
                                      Text("alguma@coisa.com")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [Text("País:"), Text("Brasil")],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Partidas Jogadas:"),
                                      Text("0")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Código:"),
                                      Text("12345678")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Maior pontuação:"),
                                      Text("0")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Maior distância:"),
                                      Text("0 m")
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]),
                    )
                  ])
            ],
          ),
        )
      ],
    );
  }
}
