import '../shared/http/http_client.dart';
import '../models/produto.dart';

abstract class IProdutoService {
  Future<List<Produto>> listarProdutos();
  Future<Produto> obterProduto(String id);
  Future<Produto> criarProduto(Produto produto);
  Future<Produto> atualizarProduto(String id, Produto produto);
  Future<void> excluirProduto(String id);
}

class ProdutoService implements IProdutoService {
  final IHttpClient _httpClient;

  ProdutoService(this._httpClient);

  @override
  Future<List<Produto>> listarProdutos() async {
    final response = await _httpClient.get('/produtos');
    return (response.data as List)
        .map((json) => Produto.fromJson(json))
        .toList();
  }

  @override
  Future<Produto> obterProduto(String id) async {
    final response = await _httpClient.get('/produtos/$id');
    return Produto.fromJson(response.data);
  }

  @override
  Future<Produto> criarProduto(Produto produto) async {
    final response = await _httpClient.post(
      '/produtos',
      data: produto.toJson(),
    );
    return Produto.fromJson(response.data);
  }

  @override
  Future<Produto> atualizarProduto(String id, Produto produto) async {
    final response = await _httpClient.put(
      '/produtos/$id',
      data: produto.toJson(),
    );
    return Produto.fromJson(response.data);
  }

  @override
  Future<void> excluirProduto(String id) async {
    await _httpClient.delete('/produtos/$id');
  }
}
