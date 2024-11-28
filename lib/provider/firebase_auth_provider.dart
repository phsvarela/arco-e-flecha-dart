import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_final/provider/firestore_provider.dart';
import '../model/user_model.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;  

  Stream<UserModel?> get user {
    return _firebaseAuth
        .authStateChanges()
        .map((event) => _userFromFirebaseUser(event));
  }

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(user.uid) : null;
  }

  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;      

      return _userFromFirebaseUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;      

      return _userFromFirebaseUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserAuth(String uid) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      User? user = _firebaseAuth.currentUser;

      final String email = user!.email!;
      final AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);      
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();    
  }
}
