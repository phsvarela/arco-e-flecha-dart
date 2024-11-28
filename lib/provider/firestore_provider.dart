import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_final/model/player.dart';

class FirestoreDatabase {
  static FirestoreDatabase helper = FirestoreDatabase._createInstance();

  FirestoreDatabase._createInstance();

  String? uid;

  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('player');

  Future<void> createPlayer(
      String uid, String email, String username, String password) async {
    try {
      Player jogador =
          Player(uid: uid, email: email, username: username, senha: password);

      await playerCollection.doc(uid).set(jogador.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePlayerScore(int novosPontos) async {
    try {
      Player jogador = await getPlayer();
      jogador = jogador.updatePontos(jogador, novosPontos);

      await playerCollection.doc(uid).set(jogador.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<Player> getPlayer() async {
    DocumentSnapshot ref = await playerCollection.doc(uid).get();

    Player player = Player.fromMap(ref.data());
    return player;
  }

  Future<List<Player>> getAllPlayers() async {
    QuerySnapshot snapshot = await playerCollection.get();
    List<Player> players = [];

    for (var doc in snapshot.docs) {
      Player player = Player.fromMap(doc.data());
      players.add(player);
    }

    return players;
  }

  Future<String> deleteUser() async {
    try {
      await playerCollection.doc(uid).delete();
      return uid!;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePlayerPassword(String newPassword) async {
    try {
      Player player = await getPlayer();

      player.changePassword(player, newPassword);
      await playerCollection.doc(uid).set(player.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
