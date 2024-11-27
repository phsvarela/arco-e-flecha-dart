import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_final/model/user_model.dart';

class DataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Usuario?> getUsuario(String id) {
    return _firestore
        .collection('usuarios')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return Usuario.fromMap(snapshot.data()!);
      }
      return null;
    });
  }

  Future<void> criarUsuario(Usuario usuario) async {
    await _firestore
        .collection('usuarios')
        .doc(usuario.id)
        .set(usuario.toMap());
  }

  Future<void> atualizarUsuario(Usuario usuario) async {
    await _firestore
        .collection('usuarios')
        .doc(usuario.id)
        .update(usuario.toMap());
  }
}
