import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  void go(String location) => GoRouter.of(this).go(location);

  void push(String location) => GoRouter.of(this).push(location);

  void pop<T extends Object?>([T? result]) => GoRouter.of(this).pop(result);

  void replace(String location) => GoRouter.of(this).replace(location);

  String get location {
    final router = GoRouter.of(this);
    final RouteMatch lastMatch =
        router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  void refresh() => GoRouter.of(this).refresh();
}
