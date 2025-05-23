class ComplementoProduto {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagem;
  final String codigoPDV;
  final bool ativo;
  final int tempoPreparoExtra; // em minutos

  const ComplementoProduto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagem,
    required this.codigoPDV,
    required this.ativo,
    this.tempoPreparoExtra = 0,
  });

  ComplementoProduto copyWith({
    String? id,
    String? nome,
    String? descricao,
    double? preco,
    String? imagem,
    String? codigoPDV,
    bool? ativo,
    int? tempoPreparoExtra,
  }) {
    return ComplementoProduto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      preco: preco ?? this.preco,
      imagem: imagem ?? this.imagem,
      codigoPDV: codigoPDV ?? this.codigoPDV,
      ativo: ativo ?? this.ativo,
      tempoPreparoExtra: tempoPreparoExtra ?? this.tempoPreparoExtra,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'imagem': imagem,
      'codigoPDV': codigoPDV,
      'ativo': ativo,
      'tempoPreparoExtra': tempoPreparoExtra,
    };
  }

  factory ComplementoProduto.fromJson(Map<String, dynamic> json) {
    return ComplementoProduto(
      id: json['id'] as String,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      preco: (json['preco'] as num).toDouble(),
      imagem: json['imagem'] as String,
      codigoPDV: json['codigoPDV'] as String,
      ativo: json['ativo'] as bool,
      tempoPreparoExtra: json['tempoPreparoExtra'] as int? ?? 0,
    );
  }
}
