import 'package:admin/services/dashboard_service.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({super.key});

  @override
  State<StorageDetails> createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {
  final DashboardService _dashboardService = DashboardService();
  bool _isLoading = true;
  String? _error;
  int _totalProducts = 0;
  int _totalGroups = 0;
  int _monthlyOrders = 0;
  int _activeCustomers = 0;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      final response = await _dashboardService.getDashboardData();
      setState(() {
        if (response.success && response.data != null) {
          _totalProducts = response.data!.totalProducts;
          _totalGroups = response.data!.totalGroups;
          _monthlyOrders = response.data!.monthlyOrders;
          _activeCustomers = response.data!.activeCustomers;
          _error = null;
        } else {
          _error = response.error ?? 'Erro ao carregar dados';
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar dados: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Resumo do Sistema",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: defaultPadding),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_error != null)
            Center(
              child: Column(
                children: [
                  Text(_error!, style: TextStyle(color: Colors.red)),
                  SizedBox(height: defaultPadding),
                  ElevatedButton(
                    onPressed: _loadDashboardData,
                    child: Text("Tentar novamente"),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                Chart(),
                StorageInfoCard(
                  svgSrc: "assets/icons/Documents.svg",
                  title: "Produtos Cadastrados",
                  amountOfFiles: "Total",
                  numOfFiles: _totalProducts,
                ),
                StorageInfoCard(
                  svgSrc: "assets/icons/media.svg",
                  title: "Grupos Reutilizáveis",
                  amountOfFiles: "Total",
                  numOfFiles: _totalGroups,
                ),
                StorageInfoCard(
                  svgSrc: "assets/icons/folder.svg",
                  title: "Pedidos do Mês",
                  amountOfFiles: "Total",
                  numOfFiles: _monthlyOrders,
                ),
                StorageInfoCard(
                  svgSrc: "assets/icons/unknown.svg",
                  title: "Clientes Ativos",
                  amountOfFiles: "Total",
                  numOfFiles: _activeCustomers,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
