import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'cardapio_item.dart';
import '../criar_produto/criar_produto_screen.dart';
import 'package:go_router/go_router.dart';

class CardapioCategoria extends StatelessWidget {
  const CardapioCategoria({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Frango assado',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/criar-produto');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: primaryColor,
                    elevation: 0,
                    side: BorderSide(color: primaryColor),
                  ),
                  child: Text('+ Adicionar item'),
                ),
                SizedBox(width: 16),
                Text('Pausado'),
                Switch(value: false, onChanged: (v) {}),
              ],
            ),
            SizedBox(height: 16),
            CardapioItem(
              nome: 'Frango assado (inteiro)',
              preco: 43.99,
              pausado: true,
              estoque: 5,
              imagem: 'assets/images/frango_inteiro.png',
            ),
            CardapioItem(
              nome: 'Frango assado (meio)',
              preco: 26.99,
              pausado: true,
              estoque: 5,
              imagem: 'assets/images/frango_meio.png',
            ),
          ],
        ),
      ),
    );
  }
}
