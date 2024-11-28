import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc.dart';
import 'blocs/navigation_bloc.dart';
import 'view/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBHfaXyHzOmNc3L_j841AFpiwwVdXo3szA",
            authDomain: "si700-260871.firebaseapp.com",
            databaseURL: "https://si700-260871-default-rtdb.firebaseio.com",
            projectId: "si700-260871",
            storageBucket: "si700-260871.firebasestorage.app",
            messagingSenderId: "506780627659",
            appId: "1:506780627659:web:6560b1d7b652650e2aa14e"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => NavigationBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
