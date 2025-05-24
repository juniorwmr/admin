import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:go_router/go_router.dart';
import 'screens/main/main_screen.dart';
import 'features/produtos/components/produto_cadastro_wizard.dart';
import 'features/produtos/screens/produtos_screen.dart';
import 'features/grupos/screens/grupos_reutilizaveis_screen.dart';
import 'features/documentos/screens/documentos_screen.dart';
import 'features/drive/screens/drive_screen.dart';

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
        GoRoute(
          path: '/documentos',
          builder: (context, state) => const DocumentosScreen(),
        ),
        GoRoute(
          path: '/drive',
          builder: (context, state) => const DriveScreen(),
        ),
      ],
    ),
  ],
);
