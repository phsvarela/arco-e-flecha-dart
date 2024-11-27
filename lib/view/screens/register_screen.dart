import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/auth_bloc.dart';
import 'package:projeto_final/constants/colors_constants.dart';
import 'package:projeto_final/widgets/custom_square.dart';
import '../../blocs/navigation_bloc.dart';
import '../../widgets/header.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const SizedBox(height: 70),
        Header(
          title: "Crie sua conta",
          showBackButton: true,
          onBackPressed: () =>
              BlocProvider.of<NavigationBloc>(context).add(GoToInitial()),
        ),
        const SizedBox(height: 150),
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomSquare(
                padding: 20,
                width: 400,
                height: 70,
                borderRadius: 20,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(label: Text("Digite seu e-mail")),
                    onSaved: (value) {
                      email = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Email é obrigatório';
                      }

                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Insira um email válido';
                      }

                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomSquare(
                padding: 20,
                width: 400,
                height: 70,
                borderRadius: 20,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Confirme seu e-mail")),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Email é obrigatório';
                      }

                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Insira um email válido';
                      }

                      if (value != email) {
                        return 'Os emails não são iguais';
                      }

                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomSquare(
                padding: 20,
                width: 400,
                height: 70,
                borderRadius: 20,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Digite seu nome de usuário")),
                    onSaved: (value) {
                      username = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Nome de usuario é obrigatório';
                      }

                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomSquare(
                padding: 20,
                width: 400,
                height: 70,
                borderRadius: 20,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(label: Text("Digite sua senha")),
                    onSaved: (value) {
                      password = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Senha é obrigatório';
                      }

                      if (value.length < 6) {
                        return 'Senha curta demais';
                      }

                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomSquare(
                padding: 20,
                width: 400,
                height: 70,
                borderRadius: 20,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Confirme sua senha")),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Senha é obrigatório';
                      }

                      if (value.length < 6) {
                        return 'Senha curta demais';
                      }

                      if (value != password) {
                        return 'As senhas não são iguais';
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomSquare(
                padding: 20,
                width: 150,
                height: 70,
                borderRadius: 20,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      BlocProvider.of<AuthBloc>(context).add(RegisterUser(
                          email: email, usuario: username, senha: password));
                    },
                  );
                },
                children: const [
                  Center(
                    child: Text(
                      "Confirmar",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(ColorsConstants.text)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
