import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import '../../controllers/produto_controller.dart';

class PassoDadosProduto extends StatefulWidget {
  const PassoDadosProduto({super.key});

  @override
  State<PassoDadosProduto> createState() => _PassoDadosProdutoState();
}

class _PassoDadosProdutoState extends State<PassoDadosProduto> {
  final controller = Injector.appInstance.get<ProdutoController>();
  bool _ativo = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    controller.produto.addListener(() {
      final produto = controller.produto.value;
      if (produto != null) {
        controller.wizardController.nomeController.text = produto.nome;
        controller.wizardController.descricaoController.text =
            produto.descricao;
        controller.wizardController.imagemController.text = produto.imagem;
        controller.wizardController.precoController.text =
            produto.preco.toString();
        _ativo = produto.ativo;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller.wizardController.nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome do Produto*',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.wizardController.descricaoController,
            decoration: const InputDecoration(
              labelText: 'Descrição (opcional)',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.wizardController.imagemController,
            decoration: const InputDecoration(
              labelText: 'URL da Imagem (opcional)',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.wizardController.precoController,
            decoration: const InputDecoration(
              labelText: 'Preço*',
              prefixText: 'R\$ ',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Ativo'),
              Switch(
                value: _ativo,
                onChanged: (v) {
                  setState(() => _ativo = v);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
