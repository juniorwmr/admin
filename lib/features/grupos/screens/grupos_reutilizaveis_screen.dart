import 'package:admin/extensions/string.dart';
import 'package:admin/shared/widget_collapsible.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import '../../produtos/controllers/produto_controller.dart';
import '../models/grupo_complemento.dart';
import '../../produtos/models/complemento_produto.dart';

class GruposReutilizaveisScreen extends StatelessWidget {
  const GruposReutilizaveisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Injector.appInstance.get<ProdutoController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos Reutilizáveis'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _mostrarDialogoNovoGrupo(context, controller),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.gruposReutilizaveis,
        builder: (context, grupos, _) {
          if (grupos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nenhum grupo reutilizável cadastrado ainda.'),
                  const SizedBox(height: 16),
                  IconButton.outlined(
                    onPressed: () =>
                        _mostrarDialogoNovoGrupo(context, controller),
                    icon: const Icon(Icons.add),
                    tooltip: 'Adicionar Grupo',
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: grupos.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final grupo = grupos[index];
              return WidgetCollapsible(
                title: grupo.nome,
                subtitle: Text(grupo.obrigatorio ? "Obrigatório" : "Opcional"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (grupo.descricao.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(grupo.descricao),
                          ),
                        const Text(
                          'Complementos:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (grupo.complementos.isEmpty)
                          const Text('Nenhum complemento cadastrado.'),
                        ...grupo.complementos.map(
                          (c) => ListTile(
                            title: Text(c.nome),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('R\$ ${c.preco.toStringAsFixed(2)}'),
                                const SizedBox(height: 4),
                                Text(
                                  c.obrigatorio ? 'Obrigatório' : 'Opcional',
                                  style: TextStyle(
                                    color: Colors.blueGrey.shade400,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  ' Qtd mínima: ${c.qtdMin} - Qtd máxima: ${c.qtdMax}',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (c.tempoPreparoExtra > 0)
                                  Tooltip(
                                    message: '+${c.tempoPreparoExtra} min',
                                    child: const Icon(Icons.timer),
                                  ),
                                IconButton(
                                  onPressed: () =>
                                      _mostrarDialogoEditarComplemento(
                                    context,
                                    grupo,
                                    c,
                                    controller,
                                  ),
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Confirmar exclusão'),
                                        content: Text(
                                          'Deseja realmente excluir o complemento "${c.nome}"?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              final novoGrupo = grupo.copyWith(
                                                complementos: grupo.complementos
                                                    .where((comp) =>
                                                        comp.id != c.id)
                                                    .toList(),
                                              );
                                              controller
                                                  .atualizarGrupoReutilizavel(
                                                      novoGrupo);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Excluir',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () => _mostrarDialogoNovoComplemento(
                                context,
                                grupo,
                                controller,
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text('Adicionar Complemento'),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () => _mostrarDialogoEditarGrupo(
                                context,
                                grupo,
                                controller,
                              ),
                              icon: const Icon(Icons.edit),
                              label: const Text('Editar Grupo'),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Confirmar exclusão'),
                                    content: Text(
                                      'Deseja realmente excluir o grupo "${grupo.nome}"?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.removerGrupoReutilizavel(
                                              grupo.id);
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
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text(
                                'Excluir Grupo',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  void _mostrarDialogoNovoGrupo(
      BuildContext context, ProdutoController controller) {
    final nomeController = TextEditingController();
    final descricaoController = TextEditingController();
    bool obrigatorio = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Novo Grupo'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Grupo*',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descricaoController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição (opcional)',
                  ),
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
                final grupo = GrupoComplemento(
                  id: UniqueKey().toString(),
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                  obrigatorio: obrigatorio,
                  complementos: [],
                );
                controller.adicionarGrupoReutilizavel(grupo);
                Navigator.pop(context);
              },
              child: const Text('Criar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoEditarGrupo(BuildContext context, GrupoComplemento grupo,
      ProdutoController controller) {
    final nomeController = TextEditingController(text: grupo.nome);
    final descricaoController = TextEditingController(text: grupo.descricao);
    bool obrigatorio = grupo.obrigatorio;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Editar Grupo'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Grupo*',
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
                DropdownButton<bool>(
                  value: obrigatorio,
                  items: const [
                    DropdownMenuItem(value: false, child: Text('Opcional')),
                    DropdownMenuItem(value: true, child: Text('Obrigatório')),
                  ],
                  onChanged: (v) => setState(() => obrigatorio = v ?? false),
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
                final grupoAtualizado = grupo.copyWith(
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                  obrigatorio: obrigatorio,
                );
                controller.atualizarGrupoReutilizavel(grupoAtualizado);
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoNovoComplemento(
    BuildContext context,
    GrupoComplemento grupo,
    ProdutoController controller,
  ) {
    final nomeController = TextEditingController();
    final descricaoController = TextEditingController();
    final precoController = TextEditingController();
    final imagemController = TextEditingController();
    final codigoPDVController = TextEditingController();
    final tempoPreparoController = TextEditingController();
    bool ativo = true;
    int qtdMin = 0;
    int qtdMax = 1;

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

                final obrigatorio = qtdMin > 0;
                final preco = precoController.text.toMoney();

                final complemento = ComplementoProduto(
                  id: UniqueKey().toString(),
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                  preco: preco,
                  imagem: imagemController.text,
                  codigoPDV: codigoPDVController.text,
                  ativo: ativo,
                  tempoPreparoExtra:
                      int.tryParse(tempoPreparoController.text) ?? 0,
                  qtdMin: qtdMin,
                  qtdMax: qtdMax,
                  obrigatorio: obrigatorio,
                );
                final novoGrupo = grupo.copyWith(
                  complementos: [...grupo.complementos, complemento],
                );
                controller.atualizarGrupoReutilizavel(novoGrupo);
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
    ProdutoController controller,
  ) {
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
                final novoGrupo = grupo.copyWith(
                  complementos: grupo.complementos.map((c) {
                    if (c.id == complemento.id) return complementoAtualizado;
                    return c;
                  }).toList(),
                );
                controller.atualizarGrupoReutilizavel(novoGrupo);
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
