import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_final/blocs/auth_bloc.dart';
import 'package:projeto_final/provider/firestore_provider.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(InitialScreenState()) {
    on<GoToLogin>((event, emit) => emit(LoginScreenState()));

    on<GoToMainMenu>((event, emit) => emit(MainMenuScreenState()));

    on<GoToProfile>((event, emit) => emit(ProfileScreenState()));

    on<GoToScore>((event, emit) => emit(ScoreScreenState()));

    on<GoToInitial>((event, emit) => emit(InitialScreenState()));

    on<GoToRegister>((event, emit) => emit(RegisterScreenState()));

    on<GoToConfiguration>((event, emit) => emit(ConfigurationScreenState()));

    on<GoToInfo>((event, emit) => emit(InfoScreenState()));

    on<GoToGameScreen>((event, emit) => emit(GameScreenState()));

    on<HandleGameOver>((event, emit) async {
      await FirestoreDatabase.helper.updatePlayerScore(event.score);
    });
  }
}

abstract class NavigationEvent {}

class GoToLogin extends NavigationEvent {}

class HandleGameOver extends NavigationEvent {
  final int score;
  HandleGameOver({required this.score});
}

class GoToMainMenu extends NavigationEvent {}

class GoToProfile extends NavigationEvent {}

class GoToScore extends NavigationEvent {}

class GoToInitial extends NavigationEvent {}

class GoToRegister extends NavigationEvent {}

class GoToConfiguration extends NavigationEvent {}

class GoToInfo extends NavigationEvent {}

class GoToGameScreen extends NavigationEvent {}

abstract class NavigationState {}

class LoginScreenState extends NavigationState {}

class MainMenuScreenState extends NavigationState {}

class ProfileScreenState extends NavigationState {}

class ScoreScreenState extends NavigationState {}

class InitialScreenState extends NavigationState {}

class RegisterScreenState extends NavigationState {}

class ConfigurationScreenState extends NavigationState {}

class InfoScreenState extends NavigationState {}

class GameScreenState extends NavigationState {}
