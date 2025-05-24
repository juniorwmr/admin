import '../../../shared/http/http_client.dart';
import '../models/produto_model.dart';

abstract class IProdutoService {
  Future<List<ProdutoModel>> listarProdutos();
  Future<ProdutoModel> obterProduto(String id);
  Future<ProdutoModel> criarProduto(ProdutoModel produto);
  Future<ProdutoModel> atualizarProduto(String id, ProdutoModel produto);
  Future<void> excluirProduto(String id);
}

class ProdutoService implements IProdutoService {
  final IHttpClient _httpClient;

  ProdutoService(this._httpClient);

  @override
  Future<List<ProdutoModel>> listarProdutos() async {
    final response = await _httpClient.get('/produtos');
    return (response.data as List)
        .map((json) => ProdutoModel.fromJson(json))
        .toList();
  }

  @override
  Future<ProdutoModel> obterProduto(String id) async {
    final response = await _httpClient.get('/produtos/$id');
    return ProdutoModel.fromJson(response.data);
  }

  @override
  Future<ProdutoModel> criarProduto(ProdutoModel produto) async {
    print(produto.toJson());
    final response = await _httpClient.post(
      '/produtos',
      data: produto.toJson(),
    );
    return ProdutoModel.fromJson(response.data);
  }

  @override
  Future<ProdutoModel> atualizarProduto(String id, ProdutoModel produto) async {
    final response = await _httpClient.put(
      '/produtos/$id',
      data: produto.toJson(),
    );
    return ProdutoModel.fromJson(response.data);
  }

  @override
  Future<void> excluirProduto(String id) async {
    await _httpClient.delete('/produtos/$id');
  }
}
