import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import '../controllers/produto_controller.dart';

class PassoRevisao extends StatelessWidget {
  const PassoRevisao({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Injector.appInstance.get<ProdutoController>();
    return SingleChildScrollView(
      child: ValueListenableBuilder(
          valueListenable: controller.produto,
          builder: (context, produto, child) {
            if (produto == null) {
              return const Text('Nenhum produto em edição.');
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome: ${produto.nome}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Descrição: ${produto.descricao}'),
                Text('Imagem: ${produto.imagem}'),
                Text('Status: ${produto.ativo ? "Ativo" : "Inativo"}'),
                const SizedBox(height: 16),
                const Text(
                  'Grupos de Complementos:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...produto.grupos.map(
                  (g) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${g.nome} (${g.obrigatorio ? "Obrigatório" : "Opcional"})',
                          ),
                          if (g.descricao.isNotEmpty) Text(g.descricao),
                          const SizedBox(height: 8),
                          const Text(
                            'Complementos:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (g.complementos.isEmpty)
                            const Text('Nenhum complemento cadastrado.'),
                          ...g.complementos.map(
                            (c) => ListTile(
                              title: Text(c.nome),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('R\$ ${c.preco.toStringAsFixed(2)}'),
                                  Text('Mín: ${c.qtdMin} Máx: ${c.qtdMax}'),
                                ],
                              ),
                              trailing: c.ativo
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : const Icon(Icons.cancel, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
