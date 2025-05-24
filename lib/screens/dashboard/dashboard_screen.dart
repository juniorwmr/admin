import 'package:admin/models/api_response.dart';
import 'package:admin/models/dashboard_data.dart';
import 'package:admin/services/dashboard_service.dart';
import 'package:admin/shared/widgets/error_widget.dart' as custom;
import 'package:admin/shared/widgets/loading_widget.dart';
import 'package:admin/utils/constants.dart';
import 'package:admin/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';

import 'components/header.dart';
import 'components/my_files.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardService _dashboardService;
  late Future<ApiResponse<DashboardData>> _dashboardData;
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    super.initState();
    try {
      _dashboardService = Injector.appInstance.get<DashboardService>();
      _loadDashboardData();
    } catch (e) {
      print('Erro ao obter DashboardService: $e');
      rethrow;
    }
  }

  void _loadDashboardData() {
    _dashboardData = _dashboardService.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StorageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                if (!Responsive.isMobile(context))
                  Expanded(flex: 2, child: StorageDetails()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
