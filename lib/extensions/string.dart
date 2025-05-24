extension Money on String {
  double toMoney() {
    return double.tryParse(replaceAll('R\$ ', '').replaceAll(',', '.')) ?? 0.0;
  }
}
