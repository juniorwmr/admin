import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/cardapio_header.dart';
import 'components/cardapio_categoria.dart';

class CardapioScreen extends StatelessWidget {
  const CardapioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardapioHeader(),
            SizedBox(height: defaultPadding),
            CardapioCategoria(),
          ],
        ),
      ),
    );
  }
}
