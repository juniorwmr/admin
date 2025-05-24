import '../../grupos/models/grupo_complemento.dart';

class ProdutoModel {
  final String id;
  final String nome;
  final String descricao;
  final String imagem;
  final bool ativo;
  final double preco;
  final List<GrupoComplemento> grupos;

  const ProdutoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagem,
    required this.ativo,
    required this.preco,
    required this.grupos,
  });

  ProdutoModel copyWith({
    String? id,
    String? nome,
    String? descricao,
    String? imagem,
    bool? ativo,
    double? preco,
    List<GrupoComplemento>? grupos,
  }) {
    return ProdutoModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
      ativo: ativo ?? this.ativo,
      preco: preco ?? this.preco,
      grupos: grupos ?? this.grupos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'imagem': imagem,
      'ativo': ativo,
      'preco': preco,
      'grupos': grupos.map((g) => g.toJson()).toList(),
    };
  }

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'] as String,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      imagem: json['imagem'] as String,
      ativo: json['ativo'] as bool,
      preco: (json['preco'] as num).toDouble(),
      grupos: (json['grupos'] as List)
          .map((g) => GrupoComplemento.fromJson(g as Map<String, dynamic>))
          .toList(),
    );
  }
}
