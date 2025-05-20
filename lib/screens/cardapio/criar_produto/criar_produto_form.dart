import 'package:flutter/material.dart';
import '../../../constants.dart';

class CriarProdutoForm extends StatelessWidget {
  const CriarProdutoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Principais informações',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
        Text('Nome do Produto'),
        TextField(
          decoration: InputDecoration(
            hintText: 'Ex: Molho pomodoro',
            border: OutlineInputBorder(),
            counterText: '0/80',
          ),
          maxLength: 80,
        ),
        SizedBox(height: 16),
        Text('Descrição'),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText:
                'Ex: Molho de tomate italiano clássico, preparado com tomates maduros.',
            border: OutlineInputBorder(),
            counterText: '0/1000',
          ),
          maxLength: 1000,
        ),
        SizedBox(height: 16),
        Text('Imagem do produto'),
        OutlinedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.image),
          label: Text('Adicionar imagem'),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.inventory_2, color: Colors.red),
            SizedBox(width: 8),
            Text('Ativar', style: TextStyle(color: Colors.red)),
          ],
        ),
      ],
    );
  }
}
