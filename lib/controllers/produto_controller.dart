import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/produtos/models/produto_model.dart';
import '../features/produtos/services/produto_service.dart';
import 'package:injector/injector.dart';

class ProdutoController extends ChangeNotifier {
  final _produtoService = Injector.appInstance.get<IProdutoService>();
  final _produtos = ValueNotifier<List<ProdutoModel>>([]);
  bool _isLoading = false;
  String? _error;

  ValueNotifier<List<ProdutoModel>> get produtos => _produtos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> carregarProdutos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _produtoService.listarProdutos();
      _produtos.value = response;
      _error = null;
    } catch (e) {
      _error = 'Erro ao carregar produtos: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> criarProduto(ProdutoModel produto) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final novoProduto = await _produtoService.criarProduto(produto);
      _produtos.value = [..._produtos.value, novoProduto];
      _error = null;
    } catch (e) {
      _error = 'Erro ao criar produto: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> atualizarProduto(String id, ProdutoModel produto) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final produtoAtualizado =
          await _produtoService.atualizarProduto(id, produto);
      _produtos.value = _produtos.value
          .map((p) => p.id == id ? produtoAtualizado : p)
          .toList();
      _error = null;
    } catch (e) {
      _error = 'Erro ao atualizar produto: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> excluirProduto(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _produtoService.excluirProduto(id);
      _produtos.value = _produtos.value.where((p) => p.id != id).toList();
      _error = null;
    } catch (e) {
      _error = 'Erro ao excluir produto: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void editarProduto(String id) {
    final produtoEncontrado = _produtos.value.firstWhere((p) => p.id == id);
    // TODO: Implementar lógica de edição
  }
}
