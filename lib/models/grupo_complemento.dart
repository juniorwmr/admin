import 'complemento_produto.dart';

class GrupoComplemento {
  final String id;
  final String nome;
  final String descricao;
  final bool obrigatorio;
  final int qtdMin;
  final int qtdMax;
  final List<ComplementoProduto> complementos;
  final int ordem;

  const GrupoComplemento({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.obrigatorio,
    required this.qtdMin,
    required this.qtdMax,
    required this.complementos,
    this.ordem = 0,
  });

  GrupoComplemento copyWith({
    String? id,
    String? nome,
    String? descricao,
    bool? obrigatorio,
    int? qtdMin,
    int? qtdMax,
    List<ComplementoProduto>? complementos,
    int? ordem,
  }) {
    return GrupoComplemento(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      obrigatorio: obrigatorio ?? this.obrigatorio,
      qtdMin: qtdMin ?? this.qtdMin,
      qtdMax: qtdMax ?? this.qtdMax,
      complementos: complementos ?? this.complementos,
      ordem: ordem ?? this.ordem,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'obrigatorio': obrigatorio,
      'qtdMin': qtdMin,
      'qtdMax': qtdMax,
      'complementos': complementos.map((c) => c.toJson()).toList(),
      'ordem': ordem,
    };
  }

  factory GrupoComplemento.fromJson(Map<String, dynamic> json) {
    return GrupoComplemento(
      id: json['id'] as String,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      obrigatorio: json['obrigatorio'] as bool,
      qtdMin: json['qtdMin'] as int,
      qtdMax: json['qtdMax'] as int,
      complementos: (json['complementos'] as List)
          .map((c) => ComplementoProduto.fromJson(c as Map<String, dynamic>))
          .toList(),
      ordem: json['ordem'] as int? ?? 0,
    );
  }
}
