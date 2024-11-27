class UserModel {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final int pontuacaoTotal;
  final int partidasJogadas;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    this.pontuacaoTotal = 0,
    this.partidasJogadas = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'pontuacaoTotal': pontuacaoTotal,
      'partidasJogadas': partidasJogadas,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      senha: '',
      pontuacaoTotal: map['pontuacaoTotal'] ?? 0,
      partidasJogadas: map['partidasJogadas'] ?? 0,
    );
  }
}
