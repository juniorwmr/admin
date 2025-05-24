import 'package:admin/models/api_response.dart';
import 'package:admin/models/dashboard_data.dart';
import 'package:admin/services/dashboard_service.dart';
import 'package:admin/shared/widgets/error_widget.dart' as custom;
import 'package:admin/shared/widgets/loading_widget.dart';
import 'package:admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({super.key});

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  final _dashboardService = Injector.appInstance.get<DashboardService>();
  late Future<ApiResponse<DashboardData>> _dashboardData;
  final _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  void _loadDashboardData() {
    _dashboardData = _dashboardService.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse<DashboardData>>(
      future: _dashboardData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (snapshot.hasError) {
          return custom.CustomErrorWidget(
            message: 'Erro ao carregar dados: ${snapshot.error}',
            onRetry: _loadDashboardData,
          );
        }

        if (!snapshot.hasData || !snapshot.data!.success) {
          return custom.CustomErrorWidget(
            message: snapshot.data?.message ?? 'Erro ao carregar dados',
            onRetry: _loadDashboardData,
          );
        }

        final data = snapshot.data!.data!;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Resumo",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: "Total de Produtos",
                    value: data.totalProducts.toString(),
                    icon: Icons.inventory_2,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: defaultPadding),
                Expanded(
                  child: _buildSummaryCard(
                    title: "Total de Grupos",
                    value: data.totalGroups.toString(),
                    icon: Icons.category,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: "Pedidos do Mês",
                    value: data.monthlyOrders.toString(),
                    icon: Icons.shopping_cart,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: defaultPadding),
                Expanded(
                  child: _buildSummaryCard(
                    title: "Clientes Ativos",
                    value: data.activeCustomers.toString(),
                    icon: Icons.people,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
