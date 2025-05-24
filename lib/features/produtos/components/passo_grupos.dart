import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import '../controllers/produto_controller.dart';
import '../../grupos/models/grupo_complemento.dart';

class PassoGrupos extends StatelessWidget {
  const PassoGrupos({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Grupos de Complementos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _mostrarDialogoNovoGrupo(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Novo Grupo'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (produto.grupos.isEmpty)
              const Center(
                child: Text('Nenhum grupo adicionado ainda.'),
              )
            else
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: produto.grupos.length,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final grupos = List<GrupoComplemento>.from(produto.grupos);
                  final grupo = grupos.removeAt(oldIndex);
                  grupos.insert(newIndex, grupo);
                  controller.reordenarGrupos(grupos);
                },
                itemBuilder: (context, index) {
                  final grupo = produto.grupos[index];
                  return Card(
                    key: ValueKey(grupo.id),
                    child: ListTile(
                      title: Text(grupo.nome),
                      subtitle: Text(
                        grupo.obrigatorio ? "Obrigatório" : "Opcional",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                _mostrarDialogoEditarGrupo(context, grupo),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
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
                                        controller.removerGrupo(grupo.id);
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
                    ),
                  );
                },
              ),
            const SizedBox(height: 16),
            const Text(
              'Grupos Reutilizáveis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: controller.gruposReutilizaveis,
              builder: (context, gruposReutilizaveis, _) {
                if (gruposReutilizaveis.isEmpty) {
                  return const Center(
                    child: Text('Nenhum grupo reutilizável disponível.'),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: gruposReutilizaveis.length,
                  itemBuilder: (context, index) {
                    final grupo = gruposReutilizaveis[index];
                    final jaAdicionado =
                        produto.grupos.any((g) => g.id == grupo.id);
                    return Card(
                      child: ListTile(
                        title: Text(grupo.nome),
                        subtitle: Text(
                          grupo.obrigatorio ? "Obrigatório" : "Opcional",
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            jaAdicionado ? Icons.remove : Icons.add,
                            color: jaAdicionado ? Colors.red : Colors.green,
                          ),
                          onPressed: () {
                            if (jaAdicionado) {
                              controller.removerGrupo(grupo.id);
                            } else {
                              controller.adicionarGrupo(grupo);
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoNovoGrupo(BuildContext context) {
    final controller = Injector.appInstance.get<ProdutoController>();
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
                final grupo = GrupoComplemento(
                  id: UniqueKey().toString(),
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                  obrigatorio: obrigatorio,
                  complementos: [],
                );
                controller.adicionarGrupo(grupo);
                Navigator.pop(context);
              },
              child: const Text('Criar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoEditarGrupo(
    BuildContext context,
    GrupoComplemento grupo,
  ) {
    final controller = Injector.appInstance.get<ProdutoController>();
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
                controller.atualizarGrupo(grupoAtualizado);
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
