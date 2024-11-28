import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/model/player.dart';
import 'package:projeto_final/model/user_model.dart';
import 'package:projeto_final/provider/firebase_auth_provider.dart';
import 'package:projeto_final/provider/firestore_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthProvider _firebaseAuthProvider = FirebaseAuthProvider();

  AuthBloc() : super(Unauthenticated()) {
    _firebaseAuthProvider.user.listen((event) {
      add(AuthServerEvent(user: event));
    });

    on<AuthServerEvent>((event, emit) {
      if (event.user == null) {
        FirestoreDatabase.helper.uid = null;
        emit(Unauthenticated());
      } else {
        FirestoreDatabase.helper.uid = event.user!.uid;
        emit(Authenticated());
        return emit(AuthSuccess(successMessage: 'Autenticado com sucesso!'));
      }
    });

    on<RegisterUser>((event, emit) async {
      try {
        UserModel? user = await _firebaseAuthProvider
            .createUserWithEmailAndPassword(event.email, event.senha);

        await FirestoreDatabase.helper
            .createPlayer(user!.uid, event.email, event.usuario, event.senha);

        return emit(AuthSuccess(successMessage: 'Conta criada com sucesso!'));
      } catch (e) {
        return emit(AuthError(
            errorMessage: 'Erro ao criar conta. Log de erro: ${e.toString()}'));
      }
    });

    on<LoginUser>((event, emit) async {
      try {
        await _firebaseAuthProvider.signInWithEmailAndPassword(
            event.email, event.senha);
      } catch (e) {
        return emit(AuthError(errorMessage: 'Usuario ou senha incorretos.'));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      try {
        String uid = await FirestoreDatabase.helper.deleteUser();
        await _firebaseAuthProvider.deleteUserAuth(uid);
        FirestoreDatabase.helper.uid = null;
        return emit(
            AuthSuccess(successMessage: 'Usuario deletado com sucesso!'));
      } catch (e) {
        return emit(AuthError(
            errorMessage:
                'Erro ao excluir conta. Log de erro: ${e.toString()}'));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      try {
        await _firebaseAuthProvider.changePassword(
            event.currentPassword, event.newPassword);

        await FirestoreDatabase.helper.changePlayerPassword(event.newPassword);

        return emit(AuthSuccess(successMessage: 'Senha alterada com sucesso'));
      } catch (e) {
        return emit(AuthError(errorMessage: 'Senha incorreta'));
      }
    });

    on<Logout>((event, emit) async {
      try {
        return await _firebaseAuthProvider.signOut();
      } catch (e) {
        return emit(AuthError(errorMessage: 'Erro ao sair da conta'));
      }
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
  final String email;
  final String senha;

  LoginUser({required this.email, required this.senha});
}

class AuthServerEvent extends AuthEvent {
  final UserModel? user;
  AuthServerEvent({required this.user});
}

class DeleteUserEvent extends AuthEvent {}

class ChangePasswordEvent extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  ChangePasswordEvent(
      {required this.currentPassword, required this.newPassword});
}

class Logout extends AuthEvent {}

abstract class AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  String errorMessage;

  AuthError({required this.errorMessage});
}

class AuthSuccess extends AuthState {
  String successMessage;

  AuthSuccess({required this.successMessage});
}
