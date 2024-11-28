class Player {
  String uid;
  String email;
  String username;
  String senha;
  int pontos;
  int quantidadePartidas;

  Player({
    required this.uid,
    required this.email,
    required this.username,
    required this.senha,
    this.pontos = 0,
    this.quantidadePartidas = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'senha': senha,
      'pontos': pontos,
      'quantidadePartidas': quantidadePartidas,
    };
  }

  factory Player.fromMap(map) {
    return Player(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      senha: map['senha'] ?? '',
      pontos: map['pontos'] ?? 0,
      quantidadePartidas: map['quantidadePartidas'] ?? 0,
    );
  }

  Player updatePontos(Player player, int pontos) {
    player.pontos += pontos;
    quantidadePartidas += 1;

    return player;
  }

  Player changePassword(Player player ,String newPassword){
    player.senha = newPassword;

    return player;
  }

  @override
  String toString() {
    return 'Player(uid: $uid, email: $email, username: $username, pontos: $pontos, quantidadePartidas: $quantidadePartidas)';
  }
}
