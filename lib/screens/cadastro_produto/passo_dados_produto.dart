import 'package:admin/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import '../../controllers/produto_controller.dart';

class PassoDadosProduto extends StatefulWidget {
  const PassoDadosProduto({super.key});

  @override
  State<PassoDadosProduto> createState() => _PassoDadosProdutoState();
}

class _PassoDadosProdutoState extends State<PassoDadosProduto> {
  final controller = Injector.appInstance.get<ProdutoController>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _imagemController = TextEditingController();
  final _precoController = TextEditingController();
  final _categoriaController = TextEditingController();
  bool _ativo = true;
  List<int> _diasSemana = [1, 2, 3, 4, 5, 6]; // Segunda a Sábado
  TimeOfDay _horaInicio = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _horaFim = const TimeOfDay(hour: 22, minute: 0);

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    controller.produto.addListener(() {
      final produto = controller.produto.value;
      if (produto != null) {
        _nomeController.text = produto.nome;
        _descricaoController.text = produto.descricao;
        _imagemController.text = produto.imagem;
        _precoController.text = produto.preco.toString();
        _categoriaController.text = produto.categoria;
        _ativo = produto.ativo;
        _diasSemana = produto.disponibilidade.diasSemana;
        _horaInicio = produto.disponibilidade.horaInicio;
        _horaFim = produto.disponibilidade.horaFim;
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _imagemController.dispose();
    _precoController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome do Produto*',
            ),
            onChanged: _salvarDados,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(
              labelText: 'Descrição (opcional)',
            ),
            maxLines: 3,
            onChanged: _salvarDados,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _imagemController,
            decoration: const InputDecoration(
              labelText: 'URL da Imagem (opcional)',
            ),
            onChanged: _salvarDados,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _precoController,
            decoration: const InputDecoration(
              labelText: 'Preço*',
              prefixText: 'R\$ ',
            ),
            keyboardType: TextInputType.number,
            onChanged: _salvarDados,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _categoriaController,
            decoration: const InputDecoration(
              labelText: 'Categoria*',
            ),
            onChanged: _salvarDados,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Ativo'),
              Switch(
                value: _ativo,
                onChanged: (v) {
                  setState(() => _ativo = v);
                  _salvarDados('');
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Disponibilidade',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildDiaSemanaChip(0, 'Dom'),
              _buildDiaSemanaChip(1, 'Seg'),
              _buildDiaSemanaChip(2, 'Ter'),
              _buildDiaSemanaChip(3, 'Qua'),
              _buildDiaSemanaChip(4, 'Qui'),
              _buildDiaSemanaChip(5, 'Sex'),
              _buildDiaSemanaChip(6, 'Sáb'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Horário de Início'),
                  subtitle: Text(
                    '${_horaInicio.hour.toString().padLeft(2, '0')}:${_horaInicio.minute.toString().padLeft(2, '0')}',
                  ),
                  onTap: () async {
                    final hora = await showTimePicker(
                      context: context,
                      initialTime: _horaInicio,
                    );
                    if (hora != null) {
                      setState(() => _horaInicio = hora);
                      _salvarDados('');
                    }
                  },
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Horário de Fim'),
                  subtitle: Text(
                    '${_horaFim.hour.toString().padLeft(2, '0')}:${_horaFim.minute.toString().padLeft(2, '0')}',
                  ),
                  onTap: () async {
                    final hora = await showTimePicker(
                      context: context,
                      initialTime: _horaFim,
                    );
                    if (hora != null) {
                      setState(() => _horaFim = hora);
                      _salvarDados('');
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiaSemanaChip(int dia, String label) {
    final selecionado = _diasSemana.contains(dia);
    return FilterChip(
      label: Text(label),
      selected: selecionado,
      onSelected: (v) {
        setState(() {
          if (v) {
            _diasSemana.add(dia);
          } else {
            _diasSemana.remove(dia);
          }
        });
        _salvarDados('');
      },
    );
  }

  void _salvarDados(String _) {
    if (_nomeController.text.isEmpty) return;
    if (_categoriaController.text.isEmpty) return;

    final disponibilidade = Disponibilidade(
      diasSemana: _diasSemana,
      horaInicio: _horaInicio,
      horaFim: _horaFim,
    );

    controller.atualizarDadosPrincipais(
      nome: _nomeController.text,
      descricao: _descricaoController.text,
      imagem: _imagemController.text,
      ativo: _ativo,
      categoria: _categoriaController.text,
      preco: double.tryParse(_precoController.text) ?? 0.0,
      disponibilidade: disponibilidade,
    );
  }
}
