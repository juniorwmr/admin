import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'grupo_novo_drawer.dart';

class GrupoComplementoDrawer extends StatelessWidget {
  const GrupoComplementoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.white,
        elevation: 16,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
        child: Container(
          width: 480,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grupo de complementos',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Crie um novo grupo de complementos ou copie um que já existe no seu cardápio',
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _GrupoCard(
                        icon: Icons.add,
                        title: 'Criar novo grupo',
                        description:
                            'Você cria um grupo novo, definindo informações gerais e quais serão os complementos',
                        selected: true,
                        badge: null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _GrupoCard(
                        icon: Icons.link,
                        title: 'Copiar grupo',
                        description:
                            'Você reaproveita um grupo que já possui em seu cardápio e a gestão fica mais fácil!',
                        selected: false,
                        badge: 'mais prático',
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: 'Criar novo grupo',
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: Duration(milliseconds: 250),
                        pageBuilder: (context, anim1, anim2) {
                          return const GrupoNovoDrawer();
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text('Continuar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GrupoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final String? badge;

  const _GrupoCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: selected ? Colors.red : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        color: selected ? Colors.red.withOpacity(0.05) : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.red),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (badge != null) ...[
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(color: Colors.green[900], fontSize: 12),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 12),
          Text(description, style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
