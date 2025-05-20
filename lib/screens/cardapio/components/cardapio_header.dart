import 'package:flutter/material.dart';
import '../../../constants.dart';

class CardapioHeader extends StatelessWidget {
  const CardapioHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Cardápio',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Novo',
                style: TextStyle(color: primaryColor, fontSize: 12),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            TextButton(onPressed: () {}, child: Text('Replicar cardápio')),
            SizedBox(width: 8),
            TextButton(onPressed: () {}, child: Text('Reordenar')),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: Text('+ Adicionar categoria'),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Ative ou pause a venda dos itens de cada cardápio, altere os preços e controle seu estoque',
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar item',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 8,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
