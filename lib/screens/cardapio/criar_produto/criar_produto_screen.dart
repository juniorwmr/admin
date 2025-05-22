import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'criar_produto_form.dart';
import 'criar_produto_preview.dart';
import '../../../responsive.dart';
import './grupo_complemento_screen.dart';
import './grupo_complemento_drawer.dart';
import 'package:go_router/go_router.dart';

class CriarProdutoScreen extends StatelessWidget {
  const CriarProdutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Criar produto preparado',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => context.go('/cardapio'),
            child: Text('Fechar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: CriarProdutoForm()),
              SizedBox(width: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () => context.go('/cardapio'),
              child: Text('Voltar'),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: () =>
                  context.go('/cardapio/criar-produto/grupos-complementos'),
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
