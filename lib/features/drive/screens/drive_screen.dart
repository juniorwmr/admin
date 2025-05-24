import 'package:flutter/material.dart';
import 'package:admin/utils/constants.dart';

class DriveScreen extends StatelessWidget {
  const DriveScreen({super.key});

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
              "Drive",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: defaultPadding),
            // TODO: Implementar integração com Google Drive
            Center(
              child: Text("Integração com Google Drive em desenvolvimento"),
            ),
          ],
        ),
      ),
    );
  }
}
