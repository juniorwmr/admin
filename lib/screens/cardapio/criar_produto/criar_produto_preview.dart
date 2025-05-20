import 'dart:io';
import 'package:flutter/material.dart';

class CriarProdutoPreview extends StatelessWidget {
  final String nome;
  final String descricao;
  final File? imagem;
  final bool estoqueAtivo;

  const CriarProdutoPreview({
    super.key,
    required this.nome,
    required this.descricao,
    required this.imagem,
    required this.estoqueAtivo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Essa é uma simulação do seu produto no app do iFood',
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: 260,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: Colors.black12, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              // Notch
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 8),
                width: 80,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Imagem
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  image: imagem != null
                      ? DecorationImage(
                          image: FileImage(imagem!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imagem == null
                    ? Center(
                        child: Icon(Icons.image, size: 48, color: Colors.white),
                      )
                    : null,
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nome.isEmpty ? 'Nome do produto' : nome,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      descricao.isEmpty ? 'Descrição' : descricao,
                      style: TextStyle(color: Colors.black54),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2,
                          size: 18,
                          color: estoqueAtivo ? Colors.green : Colors.red,
                        ),
                        SizedBox(width: 6),
                        Text(
                          estoqueAtivo ? 'Estoque ativado' : 'Sem estoque',
                          style: TextStyle(
                            color: estoqueAtivo ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              // Simulações de botões do app
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
