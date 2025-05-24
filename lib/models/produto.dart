class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String? imagem;
  final String? grupoId;
  final bool ativo;
  final DateTime dataCriacao;
  final DateTime dataAtualizacao;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    this.imagem,
    this.grupoId,
    required this.ativo,
    required this.dataCriacao,
    required this.dataAtualizacao,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      preco: json['preco'].toDouble(),
      imagem: json['imagem'],
      grupoId: json['grupoId'],
      ativo: json['ativo'],
      dataCriacao: DateTime.parse(json['dataCriacao']),
      dataAtualizacao: DateTime.parse(json['dataAtualizacao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'imagem': imagem,
      'grupoId': grupoId,
      'ativo': ativo,
      'dataCriacao': dataCriacao.toIso8601String(),
      'dataAtualizacao': dataAtualizacao.toIso8601String(),
    };
  }

  Produto copyWith({
    String? id,
    String? nome,
    String? descricao,
    double? preco,
    String? imagem,
    String? grupoId,
    bool? ativo,
    DateTime? dataCriacao,
    DateTime? dataAtualizacao,
  }) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      preco: preco ?? this.preco,
      imagem: imagem ?? this.imagem,
      grupoId: grupoId ?? this.grupoId,
      ativo: ativo ?? this.ativo,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
    );
  }
}
