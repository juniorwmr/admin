import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:go_router/go_router.dart';
import 'screens/main/main_screen.dart';
import 'screens/cadastro_produto/cadastro_produto_wizard.dart';
import 'screens/produtos/produtos_screen.dart';
import 'screens/grupos_reutilizaveis/grupos_reutilizaveis_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/produtos',
          builder: (context, state) => const ProdutosScreen(),
        ),
        GoRoute(
          path: '/grupos-reutilizaveis',
          builder: (context, state) => const GruposReutilizaveisScreen(),
        ),
        GoRoute(
          path: '/cadastro-produto',
          builder: (context, state) => const CadastroProdutoWizard(),
        ),
        GoRoute(
          path: '/editar-produto/:id',
          builder: (context, state) => CadastroProdutoWizard(
            produtoId: state.pathParameters['id'],
          ),
        ),
      ],
    ),
  ],
);
