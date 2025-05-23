import 'package:flutter/material.dart';

class WidgetCollapsible extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool collapsed;
  final Widget? leading;
  final Widget? trailing;
  final Widget? subtitle;
  const WidgetCollapsible({
    super.key,
    required this.title,
    required this.children,
    this.collapsed = false,
    this.subtitle,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      collapsedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
      leading: leading,
      title: Text(title),
      subtitle: subtitle,
      trailing: trailing,
      children: children,
    );
  }
}
