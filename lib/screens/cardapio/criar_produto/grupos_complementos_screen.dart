import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../responsive.dart';
import 'grupo_complemento_screen.dart';
import 'grupo_novo_drawer.dart';

class GruposComplementosScreen extends StatelessWidget {
  const GruposComplementosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Grupos de Complementos: os',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'clientes amam e você vende mais',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: 'Grupo de complementos',
                        barrierColor: Colors.black.withOpacity(0.2),
                        transitionDuration: Duration(milliseconds: 250),
                        pageBuilder: (context, anim1, anim2) {
                          return const GrupoComplementoDrawer();
                        },
                        transitionBuilder: (context, anim1, anim2, child) {
                          return SlideTransition(
                            position:
                                Tween<Offset>(
                                  begin: Offset(1, 0),
                                  end: Offset(0, 0),
                                ).animate(
                                  CurvedAnimation(
                                    parent: anim1,
                                    curve: Curves.easeOut,
                                  ),
                                ),
                            child: child,
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.red, size: 20),
                    label: Text(
                      'Adicionar grupo',
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.swap_vert, color: Colors.red, size: 20),
                label: Text(
                  'Reordenar',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              SizedBox(height: 16),
              _buildGrupoCard(context),
              SizedBox(height: 16),
              _buildPreviewIFood(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrupoCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.restaurant_menu,
                        color: Colors.grey[700],
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'teste',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Contém 3 complementos',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'Criar novo grupo',
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionDuration: Duration(milliseconds: 250),
                              pageBuilder: (context, anim1, anim2) {
                                return const GrupoNovoDrawer();
                              },
                              transitionBuilder:
                                  (context, anim1, anim2, child) {
                                    return SlideTransition(
                                      position:
                                          Tween<Offset>(
                                            begin: Offset(1, 0),
                                            end: Offset(0, 0),
                                          ).animate(
                                            CurvedAnimation(
                                              parent: anim1,
                                              curve: Curves.easeOut,
                                            ),
                                          ),
                                      child: child,
                                    );
                                  },
                            );
                          },
                          icon: Icon(Icons.add, color: Colors.red, size: 20),
                          label: Text(
                            'Complementos',
                            style: TextStyle(color: Colors.red),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            Icons.pause,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.expand_less,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ],
                    ),
                    _buildQuantityControls(),
                  ],
                ),
                SizedBox(height: 16),
                _buildComplementosTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls() {
    return Row(
      children: [
        Text(
          'Qtd. mínima',
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
        SizedBox(width: 8),
        _buildQuantityInput('1'),
        SizedBox(width: 16),
        Text(
          'Qtd. máxima',
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
        SizedBox(width: 8),
        _buildQuantityInput('3'),
      ],
    );
  }

  Widget _buildQuantityInput(String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(Icons.remove, size: 16, color: Colors.grey[600]),
          SizedBox(width: 16),
          Text(value, style: TextStyle(color: Colors.black87, fontSize: 14)),
          SizedBox(width: 16),
          Icon(Icons.add, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildComplementosTable() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  'Imagem',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Produto',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 100,
                child: Text(
                  'Preço',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 100,
                child: Text(
                  'Código PDV',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 100,
                child: Text(
                  'Ações',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        _ComplementoItem(nome: 'teste', preco: '0,00', codigoPDV: 'XGAHTQ'),
        _ComplementoItem(nome: 'teste', preco: '0,00', codigoPDV: 'XGAHTQ'),
        _ComplementoItem(nome: 'teste', preco: '0,00', codigoPDV: 'XGAHTQ'),
      ],
    );
  }

  Widget _buildPreviewIFood() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 300,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.phone_iphone, size: 16, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  'Essa é uma simulação do seu',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            Text(
              'produto no app do iFood',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'teste',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'teste',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'teste',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        Text(
                          ' • 0 de 3',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'teste',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '+ R\$ 0,00',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'teste',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '+ R\$ 0,00',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComplementoItem extends StatelessWidget {
  final String nome;
  final String preco;
  final String codigoPDV;

  const _ComplementoItem({
    required this.nome,
    required this.preco,
    required this.codigoPDV,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.image_outlined,
              color: Colors.grey[400],
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                Text(
                  nome,
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
                SizedBox(width: 8),
                Icon(Icons.remove_circle, color: Colors.red, size: 16),
              ],
            ),
          ),
          SizedBox(width: 16),
          Container(
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'R\$ $preco',
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
          SizedBox(width: 16),
          Container(
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              codigoPDV,
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
          SizedBox(width: 16),
          SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.pause, size: 20, color: Colors.grey[600]),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
