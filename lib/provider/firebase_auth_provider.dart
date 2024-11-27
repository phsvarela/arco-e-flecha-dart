import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel?> createUserWithEmailAndPassword(String email, String password) async {
    
  }
}
