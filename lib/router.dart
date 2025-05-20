import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/main/main_screen.dart';
import 'screens/cardapio/cardapio_screen.dart';
import 'screens/cardapio/criar_produto/criar_produto_screen.dart';
import 'screens/cardapio/criar_produto/grupos_complementos_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const CardapioScreen(),
          routes: [
            GoRoute(
              path: 'criar-produto',
              builder: (context, state) => const CriarProdutoScreen(),
              routes: [
                GoRoute(
                  path: 'grupos-complementos',
                  builder: (context, state) => const GruposComplementosScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
