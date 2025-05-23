import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import '../../controllers/produto_controller.dart';
import '../../models/complemento_produto.dart';
import '../../models/grupo_complemento.dart';

class PassoComplementos extends StatelessWidget {
  const PassoComplementos({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Injector.appInstance.get<ProdutoController>();
    return ValueListenableBuilder(
      valueListenable: controller.produto,
      builder: (context, produto, _) {
        if (produto == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (produto.grupos.isEmpty)
              const Center(
                child: Text('Adicione grupos primeiro.'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: produto.grupos.length,
                itemBuilder: (context, index) {
                  final grupo = produto.grupos[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(grupo.nome),
                          subtitle: Text(
                            grupo.obrigatorio ? "Obrigatório" : "Opcional",
                          ),
                          trailing: TextButton.icon(
                            onPressed: () => _mostrarDialogoNovoComplemento(
                              context,
                              grupo,
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text('Adicionar Complemento'),
                          ),
                        ),
                        if (grupo.complementos.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Nenhum complemento adicionado ainda.'),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: grupo.complementos.length,
                            itemBuilder: (context, index) {
                              final complemento = grupo.complementos[index];
                              return ListTile(
                                leading: complemento.imagem.isNotEmpty
                                    ? Image.network(
                                        complemento.imagem,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                    Icons.image_not_supported),
                                      )
                                    : const Icon(Icons.image_not_supported),
                                title: Text(complemento.nome),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'R\$ ${complemento.preco.toStringAsFixed(2)}'),
                                    if (complemento.descricao.isNotEmpty)
                                      Text(
                                        complemento.descricao,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    if (complemento.tempoPreparoExtra > 0)
                                      Text(
                                        '+${complemento.tempoPreparoExtra} min',
                                        style: const TextStyle(
                                          color: Colors.orange,
                                        ),
                                      ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (!complemento.ativo)
                                      const Icon(
                                        Icons.block,
                                        color: Colors.red,
                                      ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () =>
                                          _mostrarDialogoEditarComplemento(
                                        context,
                                        grupo,
                                        complemento,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                                'Confirmar exclusão'),
                                            content: Text(
                                              'Deseja realmente excluir o complemento "${complemento.nome}"?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  controller.removerComplemento(
                                                    grupo.id,
                                                    complemento.id,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Excluir',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoNovoComplemento(
    BuildContext context,
    GrupoComplemento grupo,
  ) {
    final controller = Injector.appInstance.get<ProdutoController>();
    final nomeController = TextEditingController();
    final descricaoController = TextEditingController();
    final precoController = TextEditingController();
    final imagemController = TextEditingController();
    final codigoPDVController = TextEditingController();
    final tempoPreparoController = TextEditingController();
    bool ativo = true;
    int qtdMin = 0;
    int qtdMax = 0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Novo Complemento'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Complemento*',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição (opcional)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: precoController,
                  decoration: const InputDecoration(
                    labelText: 'Preço*',
                    prefixText: 'R\$ ',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: imagemController,
                  decoration: const InputDecoration(
                    labelText: 'URL da Imagem (opcional)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: codigoPDVController,
                  decoration: const InputDecoration(
                    labelText: 'Código PDV (opcional)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: tempoPreparoController,
                  decoration: const InputDecoration(
                    labelText: 'Tempo de Preparo Extra (minutos)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Qtd. mínima'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => setState(
                                  () => qtdMin = (qtdMin - 1).clamp(0, qtdMax),
                                ),
                              ),
                              Text('$qtdMin'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => setState(
                                  () => qtdMin = (qtdMin + 1).clamp(0, qtdMax),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Qtd. máxima'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => setState(
                                  () => qtdMax = (qtdMax - 1).clamp(qtdMin, 99),
                                ),
                              ),
                              Text('$qtdMax'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => setState(
                                  () => qtdMax = (qtdMax + 1).clamp(qtdMin, 99),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Ativo'),
                    Switch(
                      value: ativo,
                      onChanged: (v) => setState(() => ativo = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (nomeController.text.isEmpty) return;
                final complemento = ComplementoProduto(
                  id: UniqueKey().toString(),
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                  preco: double.tryParse(precoController.text) ?? 0.0,
                  imagem: imagemController.text,
                  codigoPDV: codigoPDVController.text,
                  ativo: ativo,
                  tempoPreparoExtra:
                      int.tryParse(tempoPreparoController.text) ?? 0,
                  qtdMin: qtdMin,
                  qtdMax: qtdMax,
                );
                controller.adicionarComplemento(grupo.id, complemento);
                Navigator.pop(context);
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoEditarComplemento(
    BuildContext context,
    GrupoComplemento grupo,
    ComplementoProduto complemento,
  ) {
    final controller = Injector.appInstance.get<ProdutoController>();
    final nomeController = TextEditingController(text: complemento.nome);
    final descricaoController =
        TextEditingController(text: complemento.descricao);
    final precoController =
        TextEditingController(text: complemento.preco.toString());
    final imagemController = TextEditingController(text: complemento.imagem);
    final codigoPDVController =
        TextEditingController(text: complemento.codigoPDV);
    final tempoPreparoController =
        TextEditingController(text: complemento.tempoPreparoExtra.toString());
    bool ativo = complemento.ativo;
    int qtdMin = complemento.qtdMin;
    int qtdMax = complemento.qtdMax;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Editar Complemento'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Complemento*',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição (opcional)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: precoController,
                  decoration: const InputDecoration(
                    labelText: 'Preço*',
                    prefixText: 'R\$ ',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: imagemController,
                  decoration: const InputDecoration(
                    labelText: 'URL da Imagem (opcional)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: codigoPDVController,
                  decoration: const InputDecoration(
                    labelText: 'Código PDV (opcional)',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: tempoPreparoController,
                  decoration: const InputDecoration(
                    labelText: 'Tempo de Preparo Extra (minutos)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Qtd. mínima'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => setState(
                                  () => qtdMin = (qtdMin - 1).clamp(0, qtdMax),
                                ),
                              ),
                              Text('$qtdMin'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => setState(
                                  () => qtdMin = (qtdMin + 1).clamp(0, qtdMax),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Qtd. máxima'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => setState(
                                  () => qtdMax = (qtdMax - 1).clamp(qtdMin, 99),
                                ),
                              ),
                              Text('$qtdMax'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => setState(
                                  () => qtdMax = (qtdMax + 1).clamp(qtdMin, 99),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Ativo'),
                    Switch(
                      value: ativo,
                      onChanged: (v) => setState(() => ativo = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (nomeController.text.isEmpty) return;
                final complementoAtualizado = complemento.copyWith(
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                  preco: double.tryParse(precoController.text) ?? 0.0,
                  imagem: imagemController.text,
                  codigoPDV: codigoPDVController.text,
                  ativo: ativo,
                  tempoPreparoExtra:
                      int.tryParse(tempoPreparoController.text) ?? 0,
                  qtdMin: qtdMin,
                  qtdMax: qtdMax,
                );
                controller.atualizarComplemento(
                    grupo.id, complementoAtualizado);
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
