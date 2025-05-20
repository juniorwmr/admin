import 'package:flutter/material.dart';
import '../../../constants.dart';

class CardapioItem extends StatelessWidget {
  final String nome;
  final double preco;
  final bool pausado;
  final int estoque;
  final String imagem;

  const CardapioItem({
    super.key,
    required this.nome,
    required this.preco,
    required this.pausado,
    required this.estoque,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagem,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(nome, style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          SizedBox(width: 16),
          Text('R\$ ${preco.toStringAsFixed(2)}'),
          SizedBox(width: 16),
          Column(
            children: [
              Text('Pausado'),
              Switch(value: pausado, onChanged: (v) {}),
            ],
          ),
          SizedBox(width: 16),
          Row(
            children: [
              IconButton(icon: Icon(Icons.remove), onPressed: () {}),
              Text('$estoque'),
              IconButton(icon: Icon(Icons.add), onPressed: () {}),
            ],
          ),
          SizedBox(width: 8),
          TextButton(
            onPressed: () {},
            child: Text('Remover estoque', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
