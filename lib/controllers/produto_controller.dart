import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/produto.dart';
import '../models/grupo_complemento.dart';
import '../models/complemento_produto.dart';
import 'dart:convert';
import 'package:injector/injector.dart';

class ProdutoController {
  static final ProdutoController _instance = ProdutoController._internal();
  factory ProdutoController() => _instance;
  ProdutoController._internal() {
    _prefs = Injector.appInstance.get<SharedPreferences>();
    _carregarDados();
  }

  final _produtos = ValueNotifier<List<Produto>>([]);
  final _gruposReutilizaveis = ValueNotifier<List<GrupoComplemento>>([]);
  final _produto = ValueNotifier<Produto?>(null);

  late final SharedPreferences _prefs;

  ValueNotifier<List<Produto>> get produtos => _produtos;
  ValueNotifier<List<GrupoComplemento>> get gruposReutilizaveis =>
      _gruposReutilizaveis;
  ValueNotifier<Produto?> get produto => _produto;

  void _carregarDados() {
    _carregarProdutos();
    _carregarGruposReutilizaveis();
  }

  void _carregarProdutos() {
    final produtosJson = _prefs.getStringList('produtos') ?? [];
    _produtos.value =
        produtosJson.map((json) => Produto.fromJson(jsonDecode(json))).toList();
  }

  void _carregarGruposReutilizaveis() {
    final gruposJson = _prefs.getStringList('grupos_reutilizaveis') ?? [];
    _gruposReutilizaveis.value = gruposJson
        .map((json) => GrupoComplemento.fromJson(jsonDecode(json)))
        .toList();
  }

  void _salvarProdutos() {
    final produtosJson =
        _produtos.value.map((produto) => jsonEncode(produto.toJson())).toList();
    _prefs.setStringList('produtos', produtosJson);
  }

  void _salvarGruposReutilizaveis() {
    final gruposJson = _gruposReutilizaveis.value
        .map((grupo) => jsonEncode(grupo.toJson()))
        .toList();
    _prefs.setStringList('grupos_reutilizaveis', gruposJson);
  }

  void iniciarNovoProduto() {
    _produto.value = Produto(
      id: UniqueKey().toString(),
      nome: '',
      descricao: '',
      imagem: '',
      ativo: true,
      categoria: '',
      preco: 0.0,
      disponibilidade: const Disponibilidade(
        diasSemana: [1, 2, 3, 4, 5, 6], // Segunda a Sábado
        horaInicio: TimeOfDay(hour: 10, minute: 0),
        horaFim: TimeOfDay(hour: 22, minute: 0),
      ),
      grupos: [],
    );
  }

  void atualizarDadosPrincipais({
    required String nome,
    required String descricao,
    required String imagem,
    required bool ativo,
    required String categoria,
    required double preco,
    required Disponibilidade disponibilidade,
  }) {
    if (_produto.value == null) return;
    _produto.value = _produto.value!.copyWith(
      nome: nome,
      descricao: descricao,
      imagem: imagem,
      ativo: ativo,
      categoria: categoria,
      preco: preco,
      disponibilidade: disponibilidade,
    );
  }

  void adicionarGrupo(GrupoComplemento grupo) {
    if (_produto.value == null) return;
    final grupos = [..._produto.value!.grupos, grupo];
    _produto.value = _produto.value!.copyWith(grupos: grupos);
  }

  void atualizarGrupo(GrupoComplemento grupo) {
    if (_produto.value == null) return;
    final grupos = _produto.value!.grupos
        .map((g) => g.id == grupo.id ? grupo : g)
        .toList();
    _produto.value = _produto.value!.copyWith(grupos: grupos);
  }

  void removerGrupo(String grupoId) {
    if (_produto.value == null) return;
    final grupos =
        _produto.value!.grupos.where((g) => g.id != grupoId).toList();
    _produto.value = _produto.value!.copyWith(grupos: grupos);
  }

  void adicionarComplemento(String grupoId, ComplementoProduto complemento) {
    final produto = _produto.value;
    if (produto == null) return;

    final grupos = produto.grupos.map((g) {
      if (g.id == grupoId) {
        final complementos = [...g.complementos, complemento];
        return g.copyWith(complementos: complementos);
      }
      return g;
    }).toList();

    _produto.value = produto.copyWith(grupos: grupos);
    _salvarProdutos();
  }

  void atualizarComplemento(String grupoId, ComplementoProduto complemento) {
    final produto = _produto.value;
    if (produto == null) return;

    final grupos = produto.grupos.map((g) {
      if (g.id == grupoId) {
        final complementos = g.complementos.map((c) {
          if (c.id == complemento.id) return complemento;
          return c;
        }).toList();
        return g.copyWith(complementos: complementos);
      }
      return g;
    }).toList();

    _produto.value = produto.copyWith(grupos: grupos);
    _salvarProdutos();
  }

  void removerComplemento(String grupoId, String complementoId) {
    final produto = _produto.value;
    if (produto == null) return;

    final grupos = produto.grupos.map((g) {
      if (g.id == grupoId) {
        final complementos =
            g.complementos.where((c) => c.id != complementoId).toList();
        return g.copyWith(complementos: complementos);
      }
      return g;
    }).toList();

    _produto.value = produto.copyWith(grupos: grupos);
    _salvarProdutos();
  }

  Future<void> salvarProduto() async {
    // if (produto.value == null) return;
    // if (produto.value!.nome.isEmpty) return;

    final index = _produtos.value.indexWhere((p) => p.id == _produto.value!.id);
    if (index >= 0) {
      _produtos.value = [
        ..._produtos.value.sublist(0, index),
        _produto.value!,
        ..._produtos.value.sublist(index + 1),
      ];
    } else {
      _produtos.value = [..._produtos.value, _produto.value!];
    }
  }

  void removerProduto(String id) {
    _produtos.value = _produtos.value.where((p) => p.id != id).toList();
    _salvarProdutos();
  }

  void editarProduto(String id) {
    final produtoEncontrado = _produtos.value.firstWhere((p) => p.id == id);
    _produto.value = produtoEncontrado;
  }

  void limpar() {
    _produto.value = null;
  }

  void adicionarGrupoReutilizavel(GrupoComplemento grupo) {
    _gruposReutilizaveis.value = [..._gruposReutilizaveis.value, grupo];
    _salvarGruposReutilizaveis();
  }

  void removerGrupoReutilizavel(String id) {
    _gruposReutilizaveis.value =
        _gruposReutilizaveis.value.where((g) => g.id != id).toList();
    _salvarGruposReutilizaveis();
  }

  void atualizarGrupoReutilizavel(GrupoComplemento grupo) {
    _gruposReutilizaveis.value = _gruposReutilizaveis.value
        .map((g) => g.id == grupo.id ? grupo : g)
        .toList();
    _salvarGruposReutilizaveis();
  }

  void reordenarGrupos(List<GrupoComplemento> grupos) {
    if (_produto.value == null) return;
    final gruposOrdenados = grupos
        .asMap()
        .map((index, grupo) {
          return MapEntry(index, grupo.copyWith(ordem: index));
        })
        .values
        .toList();
    _produto.value = _produto.value!.copyWith(grupos: gruposOrdenados);
  }
}
