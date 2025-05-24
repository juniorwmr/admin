import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injector/injector.dart';

class ProdutoWizardController {
  static final ProdutoWizardController _instance =
      ProdutoWizardController._internal();
  factory ProdutoWizardController() => _instance;
  ProdutoWizardController._internal() {
    _prefs = Injector.appInstance.get<SharedPreferences>();
  }

  late final SharedPreferences _prefs;

  // Controllers para os campos de texto
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final imagemController = TextEditingController();
  final precoController = TextEditingController();

  // Estado do wizard
  final _currentStep = ValueNotifier<int>(0);
  ValueNotifier<int> get currentStep => _currentStep;

  // Salvar dados do step atual
  Future<void> salvarDadosStep(int step) async {
    final dados = {
      'nome': nomeController.text,
      'descricao': descricaoController.text,
      'imagem': imagemController.text,
      'preco': precoController.text,
    };

    await _prefs.setString('produto_wizard_step_$step', dados.toString());
  }

  // Carregar dados do step
  Future<void> carregarDadosStep(int step) async {
    final dadosStr = _prefs.getString('produto_wizard_step_$step');
    if (dadosStr != null) {
      // Implementar lógica para converter string em Map
      // e preencher os controllers
    }
  }

  // Limpar dados do wizard
  Future<void> limparDadosWizard() async {
    for (int i = 0; i < 4; i++) {
      await _prefs.remove('produto_wizard_step_$i');
    }
    nomeController.clear();
    descricaoController.clear();
    imagemController.clear();
    precoController.clear();
  }

  void nextStep() {
    if (_currentStep.value < 3) {
      _currentStep.value++;
    }
  }

  void previousStep() {
    if (_currentStep.value > 0) {
      _currentStep.value--;
    }
  }

  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    imagemController.dispose();
    precoController.dispose();
  }
}
