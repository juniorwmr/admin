import 'package:flutter/material.dart';
import 'grupo_complemento.dart';

class Disponibilidade {
  final List<int> diasSemana; // 0 = Domingo, 1 = Segunda, etc.
  final TimeOfDay horaInicio;
  final TimeOfDay horaFim;

  const Disponibilidade({
    required this.diasSemana,
    required this.horaInicio,
    required this.horaFim,
  });

  Disponibilidade copyWith({
    List<int>? diasSemana,
    TimeOfDay? horaInicio,
    TimeOfDay? horaFim,
  }) {
    return Disponibilidade(
      diasSemana: diasSemana ?? this.diasSemana,
      horaInicio: horaInicio ?? this.horaInicio,
      horaFim: horaFim ?? this.horaFim,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diasSemana': diasSemana,
      'horaInicio': '${horaInicio.hour}:${horaInicio.minute}',
      'horaFim': '${horaFim.hour}:${horaFim.minute}',
    };
  }

  factory Disponibilidade.fromJson(Map<String, dynamic> json) {
    final horaInicioParts = (json['horaInicio'] as String).split(':');
    final horaFimParts = (json['horaFim'] as String).split(':');

    return Disponibilidade(
      diasSemana: List<int>.from(json['diasSemana'] as List),
      horaInicio: TimeOfDay(
        hour: int.parse(horaInicioParts[0]),
        minute: int.parse(horaInicioParts[1]),
      ),
      horaFim: TimeOfDay(
        hour: int.parse(horaFimParts[0]),
        minute: int.parse(horaFimParts[1]),
      ),
    );
  }
}

class Produto {
  final String id;
  final String nome;
  final String descricao;
  final String imagem;
  final bool ativo;
  final String categoria;
  final double preco;
  final Disponibilidade disponibilidade;
  final List<GrupoComplemento> grupos;

  const Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagem,
    required this.ativo,
    required this.categoria,
    required this.preco,
    required this.disponibilidade,
    required this.grupos,
  });

  Produto copyWith({
    String? id,
    String? nome,
    String? descricao,
    String? imagem,
    bool? ativo,
    String? categoria,
    double? preco,
    Disponibilidade? disponibilidade,
    List<GrupoComplemento>? grupos,
  }) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
      ativo: ativo ?? this.ativo,
      categoria: categoria ?? this.categoria,
      preco: preco ?? this.preco,
      disponibilidade: disponibilidade ?? this.disponibilidade,
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
      'categoria': categoria,
      'preco': preco,
      'disponibilidade': disponibilidade.toJson(),
      'grupos': grupos.map((g) => g.toJson()).toList(),
    };
  }

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] as String,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      imagem: json['imagem'] as String,
      ativo: json['ativo'] as bool,
      categoria: json['categoria'] as String,
      preco: (json['preco'] as num).toDouble(),
      disponibilidade: Disponibilidade.fromJson(
          json['disponibilidade'] as Map<String, dynamic>),
      grupos: (json['grupos'] as List)
          .map((g) => GrupoComplemento.fromJson(g as Map<String, dynamic>))
          .toList(),
    );
  }
}
