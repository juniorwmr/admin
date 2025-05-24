import 'package:admin/models/api_response.dart';
import 'package:admin/models/produto.dart';
import 'package:admin/shared/config/env_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdutoService {
  final String baseUrl;

  ProdutoService() : baseUrl = EnvConfig.apiUrl;

  Future<ApiResponse<List<Produto>>> getProdutos() async {
    try {
      // TODO: Implementar chamada real à API quando estiver pronta
      // final response = await http.get(Uri.parse('$baseUrl/produtos'));

      // Dados mockados para desenvolvimento
      await Future.delayed(const Duration(seconds: 1)); // Simula delay de rede

      return ApiResponse.success([
        Produto(
          id: '1',
          nome: 'Produto 1',
          descricao: 'Descrição do Produto 1',
          preco: 100.00,
          ativo: true,
          dataCriacao: DateTime.now(),
          dataAtualizacao: DateTime.now(),
        ),
        Produto(
          id: '2',
          nome: 'Produto 2',
          descricao: 'Descrição do Produto 2',
          preco: 200.00,
          ativo: true,
          dataCriacao: DateTime.now(),
          dataAtualizacao: DateTime.now(),
        ),
        Produto(
          id: '3',
          nome: 'Produto 3',
          descricao: 'Descrição do Produto 3',
          preco: 300.00,
          ativo: false,
          dataCriacao: DateTime.now(),
          dataAtualizacao: DateTime.now(),
        ),
      ]);
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<Produto>> criarProduto(Produto produto) async {
    try {
      // TODO: Implementar chamada real à API quando estiver pronta
      // final response = await http.post(
      //   Uri.parse('$baseUrl/produtos'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode(produto.toJson()),
      // );

      // Dados mockados para desenvolvimento
      await Future.delayed(const Duration(seconds: 1)); // Simula delay de rede

      return ApiResponse.success(produto);
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<Produto>> atualizarProduto(Produto produto) async {
    try {
      // TODO: Implementar chamada real à API quando estiver pronta
      // final response = await http.put(
      //   Uri.parse('$baseUrl/produtos/${produto.id}'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode(produto.toJson()),
      // );

      // Dados mockados para desenvolvimento
      await Future.delayed(const Duration(seconds: 1)); // Simula delay de rede

      return ApiResponse.success(produto);
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }

  Future<ApiResponse<void>> excluirProduto(String id) async {
    try {
      // TODO: Implementar chamada real à API quando estiver pronta
      // final response = await http.delete(Uri.parse('$baseUrl/produtos/$id'));

      // Dados mockados para desenvolvimento
      await Future.delayed(const Duration(seconds: 1)); // Simula delay de rede

      return ApiResponse.success(null);
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }
}
