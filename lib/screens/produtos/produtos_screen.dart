import 'package:admin/shared/widget_collapsible.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injector/injector.dart';
import '../../controllers/produto_controller.dart';

class ProdutosScreen extends StatefulWidget {
  const ProdutosScreen({super.key});

  @override
  State<ProdutosScreen> createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Injector.appInstance.get<ProdutoController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/cadastro-produto'),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.produtos,
        builder: (context, produtos, _) {
          if (produtos.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('Nenhum produto cadastrado ainda.')),
                const SizedBox(height: 16),
                IconButton.outlined(
                  tooltip: 'Adicionar produto',
                  icon: const Icon(Icons.add),
                  onPressed: () => context.go('/cadastro-produto'),
                ),
              ],
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: produtos.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final produto = produtos[index];

              return WidgetCollapsible(
                title: produto.nome,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        controller.editarProduto(produto.id);
                        context.go('/editar-produto/${produto.id}');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmar exclusão'),
                            content: Text(
                              'Deseja realmente excluir o produto "${produto.nome}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.removerProduto(produto.id);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Excluir',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                leading: produto.imagem.isNotEmpty
                    ? Image.network(
                        produto.imagem,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      )
                    : const Icon(Icons.image_not_supported),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
                    if (produto.descricao.isNotEmpty)
                      Text(
                        produto.descricao,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      children: [
                        if (!produto.ativo)
                          const Chip(
                            label: Text('Inativo'),
                            backgroundColor: Colors.red,
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                      ],
                    ),
                  ],
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detalhes do Produto',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Descrição completa: ${produto.descricao}'),
                          const SizedBox(height: 16),
                          if (produto.grupos.isNotEmpty) ...[
                            const Text(
                              'Grupos de Complementos',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...produto.grupos.map((grupo) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '• ${grupo.nome}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (grupo.complementos.isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: grupo.complementos
                                              .map((complemento) => Text(
                                                    '- ${complemento.nome} (R\$ ${complemento.preco.toStringAsFixed(2)})',
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    const SizedBox(height: 8),
                                  ],
                                )),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
