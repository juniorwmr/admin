import 'package:flutter/material.dart';
import 'package:admin/utils/constants.dart';

class DocumentosScreen extends StatelessWidget {
  const DocumentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Documentos",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: defaultPadding),
            // TODO: Implementar lista de documentos
            Center(
              child: Text("Lista de documentos em desenvolvimento"),
            ),
          ],
        ),
      ),
    );
  }
}
