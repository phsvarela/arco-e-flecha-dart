import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/auth_bloc.dart';
import 'package:projeto_final/blocs/navigation_bloc.dart';
import 'package:projeto_final/model/player.dart';
import 'package:projeto_final/provider/firestore_provider.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import '../../widgets/header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Player>(
        future: FirestoreDatabase.helper.getPlayer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Jogador não encotrado'),
            );
          }

          Player player = snapshot.data!;

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
                        onBackPressed: () =>
                            BlocProvider.of<NavigationBloc>(context)
                                .add(GoToConfiguration())),
                    const SizedBox(
                      height: 150,
                    ),
                    CustomSquare(
                        padding: 20,
                        width: 450,
                        height: 400,
                        borderRadius: 20,
                        children: [
                          Center(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Você",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Código:"),
                                            Text(player.uid)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("E-mail:"),
                                            Text(player.email)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Nome de usuario:"),
                                            Text(player.username)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Partidas Jogadas:"),
                                            Text("${player.quantidadePartidas}")
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Pontuação total:"),
                                            Text("${player.pontos}")
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                          )
                        ]),
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
                              late String currentPassword;
                              late String newPassword;
                              final formKey = GlobalKey<FormState>();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: CustomSquare(
                                            padding: 20,
                                            width: 450,
                                            height: 400,
                                            borderRadius: 20,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Form(
                                                      key: formKey,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                                    label: Text(
                                                                        'Digite sua senha')),
                                                            onSaved:
                                                                (newValue) {
                                                              currentPassword =
                                                                  newValue ??
                                                                      '';
                                                            },
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value == '') {
                                                                return 'Senha não pode estar vazia';
                                                              }

                                                              return null;
                                                            },
                                                          ),
                                                          TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                                    label: Text(
                                                                        'Digite sua senha')),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value == '') {
                                                                return 'Digite sua nova senha';
                                                              }

                                                              if (value.length <
                                                                  6) {
                                                                return 'Senha muito curta';
                                                              }

                                                              newPassword =
                                                                  value;

                                                              return null;
                                                            },
                                                          ),
                                                          TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                                    label: Text(
                                                                        'Confirme a nova senha')),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value == '') {
                                                                return 'Confirme a nova senha';
                                                              }

                                                              if (value.length <
                                                                  6) {
                                                                return 'Senha muito curta';
                                                              }

                                                              if (value !=
                                                                  newPassword) {
                                                                return 'As senhas não são iguais';
                                                              }

                                                              return null;
                                                            },
                                                          ),
                                                        ],
                                                      )),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        CustomSquare(
                                                          padding: 20,
                                                          width: 180,
                                                          height: 70,
                                                          borderRadius: 20,
                                                          children: const [
                                                            Center(
                                                              child: Text(
                                                                  'Cancelar'),
                                                            )
                                                          ],
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop;
                                                          },
                                                        ),
                                                        CustomSquare(
                                                          padding: 20,
                                                          width: 180,
                                                          height: 70,
                                                          borderRadius: 20,
                                                          children: const [
                                                            Center(
                                                              child:
                                                                  Text('Mudar'),
                                                            )
                                                          ],
                                                          onTap: () {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              formKey
                                                                  .currentState!
                                                                  .save();
                                                              BlocProvider.of<
                                                                          AuthBloc>(
                                                                      context)
                                                                  .add(ChangePasswordEvent(
                                                                      currentPassword:
                                                                          currentPassword,
                                                                      newPassword:
                                                                          newPassword));
                                                            }
                                                          },
                                                        )
                                                      ])
                                                ],
                                              ),
                                            ]),
                                      ),
                                    );
                                  });
                            },
                            children: const [
                              Center(
                                child: Text(
                                  "Mudar senha",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
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
                              BlocProvider.of<AuthBloc>(context)
                                  .add(DeleteUserEvent());
                            },
                            children: const [
                              Center(
                                child: Text(
                                  "Excluir conta",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
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
              )
            ],
          );
        });
  }
}
