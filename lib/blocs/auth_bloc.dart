import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/model/user_model.dart';
import 'package:projeto_final/provider/data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_final/provider/firebase_auth_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {  
  final FirebaseAuthProvider _firebaseAuthProvider = FirebaseAuthProvider(); 

  AuthBloc() : super(Unauthenticated()) {
    on<RegisterUser>((event, emit) {
      
    });

    on<LoginUser>((event, emit) async {
    });

    on<Logout>((event, emit) {
      emit(Unauthenticated());
    });
  }
}

abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  final String email;
  final String usuario;
  final String senha;

  RegisterUser(
      {required this.email, required this.usuario, required this.senha});
}

class LoginUser extends AuthEvent {
  final String usuario;
  final String senha;

  LoginUser({required this.usuario, required this.senha});
}

class Logout extends AuthEvent {}

abstract class AuthState {}

class Authenticated extends AuthState {
  final UserModel usuario;

  Authenticated({required this.usuario});
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  String errorMessage;

  AuthError({required this.errorMessage});
}
