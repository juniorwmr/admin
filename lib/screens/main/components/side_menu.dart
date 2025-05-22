import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../extensions/navigation_extension.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset("assets/images/logo.png")),
          DrawerListTile(
            title: "Home",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              context.go('/');
            },
          ),
          DrawerListTile(
            title: "Cardápio",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              context.go('/cardapio');
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(title, style: TextStyle(color: Colors.white54)),
    );
  }
}
