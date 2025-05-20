import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'grupo_complementos_drawer.dart';

class GrupoNovoDrawer extends StatefulWidget {
  const GrupoNovoDrawer({super.key});

  @override
  State<GrupoNovoDrawer> createState() => _GrupoNovoDrawerState();
}

class _GrupoNovoDrawerState extends State<GrupoNovoDrawer> {
  final TextEditingController nomeController = TextEditingController();
  String obrigatorio = 'Opcional';
  int qtdMin = 0;
  int qtdMax = 1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.white,
        elevation: 16,
        child: Container(
          width: 540,
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
                      'Criar novo grupo',
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
                // Barra de progresso
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Passo 2 de 3',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Primeiro, defina o grupo e suas informações principais',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 32),
                Text('Nome do Grupo*', style: TextStyle(color: Colors.black87)),
                SizedBox(height: 8),
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    hintText: 'Ex: Turbine seu lanche*',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.black54),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    // Dropdown obrigatório/opcional
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Este grupo é obrigatório ou opcional?',
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: obrigatorio,
                            items: ['Opcional', 'Obrigatório']
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => obrigatorio = v ?? 'Opcional'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    // Qtd mínima
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Qtd. mínima',
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.black87),
                                onPressed: () => setState(
                                  () => qtdMin = qtdMin > 0 ? qtdMin - 1 : 0,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '$qtdMin',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.black87),
                                onPressed: () => setState(() => qtdMin++),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    // Qtd máxima
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Qtd. máxima',
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.black87),
                                onPressed: () => setState(
                                  () => qtdMax = qtdMax > 1 ? qtdMax - 1 : 1,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '$qtdMax',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.black87),
                                onPressed: () => setState(() => qtdMax++),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: Text('Voltar'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: 'Adicionar complementos',
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: Duration(milliseconds: 250),
                          pageBuilder: (context, anim1, anim2) {
                            return const GrupoComplementosDrawer();
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: Text('Continuar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
