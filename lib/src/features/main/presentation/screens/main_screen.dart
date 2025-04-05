import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Menu lateral
          Container(
            width: 250,
            color: Theme.of(context).canvasColor,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Logo ou título,
                const Text(
                  'Admin Panel',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                // Links de navegação
                _buildNavItem(context, 'Dashboard', '/', Icons.dashboard),
                _buildNavItem(context, 'Usuários', '/users', Icons.people),
                _buildNavItem(
                  context,
                  'Configurações',
                  '/settings',
                  Icons.settings,
                ),
              ],
            ),
          ),
          // Conteúdo principal
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String title,
    String route,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (route != GoRouterState.of(context).uri.path) {
          context.go(route);
        }
      },
    );
  }
}
