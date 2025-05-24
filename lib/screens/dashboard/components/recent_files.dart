import 'package:admin/models/api_response.dart';
import 'package:admin/models/dashboard_data.dart';
import 'package:admin/services/dashboard_service.dart';
import 'package:admin/shared/widgets/error_widget.dart' as custom;
import 'package:admin/shared/widgets/loading_widget.dart';
import 'package:admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({super.key});

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  final _dashboardService = Injector.appInstance.get<DashboardService>();
  late Future<ApiResponse<DashboardData>> _dashboardData;
  final _dateFormat = DateFormat('dd/MM/yyyy');
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
            onRetry: () {
              setState(() {
                _loadDashboardData();
              });
            },
          );
        }

        if (!snapshot.hasData) {
          return const custom.CustomErrorWidget(
            message: 'Nenhum dado disponível',
          );
        }

        final response = snapshot.data!;
        if (!response.success) {
          return custom.CustomErrorWidget(
            message: response.message ?? 'Erro desconhecido',
            onRetry: () {
              setState(() {
                _loadDashboardData();
              });
            },
          );
        }

        final data = response.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pedidos Recentes",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: defaultPadding),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  ...data.recentOrders.map((order) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: _getStatusColor(order.status),
                              child: Text(
                                order.customerName[0].toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: defaultPadding),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.customerName,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    'Pedido #${order.id} - ${_dateFormat.format(DateTime.parse(order.date))}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              _currencyFormat.format(order.value),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pendente':
        return Colors.orange;
      case 'aprovado':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
