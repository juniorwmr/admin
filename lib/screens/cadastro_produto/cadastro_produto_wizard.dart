import 'package:flutter/material.dart';
import '../../controllers/produto_controller.dart';
import 'passo_dados_produto.dart';
import 'passo_grupos.dart';
import 'passo_complementos.dart';
import 'passo_revisao.dart';
import 'package:go_router/go_router.dart';
import 'package:injector/injector.dart';

class CadastroProdutoWizard extends StatefulWidget {
  final String? produtoId;
  const CadastroProdutoWizard({
    super.key,
    this.produtoId,
  });

  @override
  State<CadastroProdutoWizard> createState() => _CadastroProdutoWizardState();
}

class _CadastroProdutoWizardState extends State<CadastroProdutoWizard> {
  final controller = Injector.appInstance.get<ProdutoController>();
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    if (widget.produtoId == null) {
      controller.iniciarNovoProduto();
    }
  }

  void _nextStep() async {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      // Salvar produto e redirecionar
      await controller.salvarProduto();
      if (mounted) {
        context.go('/produtos');
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.produto,
      builder: (context, produto, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cadastro de Produto'),
            centerTitle: true,
          ),
          body: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepContinue: _nextStep,
            onStepCancel: _previousStep,
            controlsBuilder: (context, details) {
              return Row(
                children: [
                  if (_currentStep > 0)
                    OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Voltar'),
                    ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(_currentStep == 3 ? 'Concluir' : 'Continuar'),
                  ),
                ],
              );
            },
            steps: [
              Step(
                title: const Text('Produto'),
                content: const PassoDadosProduto(),
                isActive: _currentStep >= 0,
                state:
                    _currentStep > 0 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: const Text('Grupos'),
                content: const PassoGrupos(),
                isActive: _currentStep >= 1,
                state:
                    _currentStep > 1 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: const Text('Complementos'),
                content: const PassoComplementos(),
                isActive: _currentStep >= 2,
                state:
                    _currentStep > 2 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: const Text('Revisão'),
                content: const PassoRevisao(),
                isActive: _currentStep >= 3,
                state:
                    _currentStep == 3 ? StepState.editing : StepState.indexed,
              ),
            ],
          ),
        );
      },
    );
  }
}
