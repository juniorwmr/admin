import 'package:flutter/material.dart';
import '../controllers/produto_controller.dart';
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

  @override
  void initState() {
    super.initState();
    if (widget.produtoId == null) {
      controller.iniciarNovoProduto();
    }
  }

  void _nextStep() async {
    if (controller.wizardController.currentStep.value < 3) {
      await controller.wizardController
          .salvarDadosStep(controller.wizardController.currentStep.value);
      controller.wizardController.nextStep();
      controller.salvarDadosPrincipais();
    } else {
      // Salvar produto e redirecionar
      await controller.salvarProduto();
      await controller.wizardController.limparDadosWizard();

      // reset step
      controller.wizardController.currentStep.value = 0;

      if (mounted) {
        context.go('/produtos');
      }
    }
  }

  void _previousStep() {
    if (controller.wizardController.currentStep.value > 0) {
      controller.wizardController.previousStep();
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
          body: ValueListenableBuilder(
            valueListenable: controller.wizardController.currentStep,
            builder: (context, currentStep, _) {
              return Stepper(
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepContinue: _nextStep,
                onStepCancel: _previousStep,
                controlsBuilder: (context, details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      spacing: 8,
                      children: [
                        if (currentStep > 0)
                          OutlinedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Voltar'),
                          ),
                        const SizedBox(width: 4),
                        ElevatedButton(
                          onPressed: details.onStepContinue,
                          child:
                              Text(currentStep == 3 ? 'Concluir' : 'Continuar'),
                        ),
                      ],
                    ),
                  );
                },
                steps: [
                  Step(
                    title: const Text('Produto'),
                    content: const PassoDadosProduto(),
                    isActive: currentStep >= 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Grupos'),
                    content: const PassoGrupos(),
                    isActive: currentStep >= 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Complementos'),
                    content: const PassoComplementos(),
                    isActive: currentStep >= 2,
                    state: currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Revisão'),
                    content: const PassoRevisao(),
                    isActive: currentStep >= 3,
                    state: currentStep == 3
                        ? StepState.editing
                        : StepState.indexed,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
