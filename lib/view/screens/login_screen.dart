import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import 'package:projeto_final/widgets/header.dart';
import '../../blocs/auth_bloc.dart';
import '../../blocs/navigation_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? senha;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Header(
                        title: "Login",
                        showBackButton: true,
                        onBackPressed: () =>
                            BlocProvider.of<NavigationBloc>(context)
                                .add(GoToInitial())),
                    const SizedBox(
                      height: 250,
                    ),
                    CustomSquare(
                        padding: 20,
                        width: 300,
                        height: 70,
                        borderRadius: 20,
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(label: Text("Email")),
                            onSaved: (String? newValue) {
                              email = newValue ?? "";
                            },
                            validator: (String? value) {
                              if (value == null || value == '') {
                                return "Insira seu email";
                              }

                              final emailRegex =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Insira um email válido';
                              }

                              return null;
                            },
                          ),
                        ]),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomSquare(
                        padding: 20,
                        width: 300,
                        height: 70,
                        borderRadius: 20,
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(label: Text("Senha")),
                            onSaved: (String? newValue) {
                              senha = newValue ?? "";
                            },
                            validator: (String? value) {
                              if (value == null) {
                                return "Insira sua senha";
                              }

                              return null;
                            },
                          ),
                        ]),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomSquare(
                        padding: 20,
                        width: 100,
                        height: 70,
                        borderRadius: 20,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            BlocProvider.of<AuthBloc>(context)
                                .add(LoginUser(email: email!, senha: senha!));
                          }
                        },
                        children: const [
                          Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ]),
                  ],
                ))),
      ],
    );
  }
}
