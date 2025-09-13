import 'package:core_localization/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Minimal placeholder view for the Products feature.
class ProductsPage extends StatelessWidget {
  /// Creates a ProductsPage.
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).products)),
      body: Center(child: Text(AppLocalizations.of(context).products)),
    );
  }
}
