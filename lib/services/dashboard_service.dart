import 'package:admin/models/api_response.dart';
import 'package:admin/models/dashboard_data.dart';
import 'package:admin/models/order.dart';
import 'package:admin/shared/config/env_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardService {
  final String baseUrl;

  DashboardService() : baseUrl = EnvConfig.apiUrl;

  Future<ApiResponse<DashboardData>> getDashboardData() async {
    try {
      // TODO: Implementar chamada real à API quando estiver pronta
      // final response = await http.get(Uri.parse('$baseUrl/dashboard'));

      // Dados mockados para desenvolvimento
      await Future.delayed(const Duration(seconds: 1)); // Simula delay de rede

      return ApiResponse.success(
        DashboardData(
          totalProducts: 156,
          totalGroups: 12,
          monthlyOrders: 45,
          activeCustomers: 89,
          recentOrders: [
            Order(
              id: '001',
              customerName: 'João Silva',
              date: '2024-03-15',
              status: 'aprovado',
              value: 1250.00,
            ),
            Order(
              id: '002',
              customerName: 'Maria Santos',
              date: '2024-03-14',
              status: 'pendente',
              value: 850.50,
            ),
            Order(
              id: '003',
              customerName: 'Pedro Oliveira',
              date: '2024-03-14',
              status: 'cancelado',
              value: 2300.75,
            ),
            Order(
              id: '004',
              customerName: 'Ana Costa',
              date: '2024-03-13',
              status: 'aprovado',
              value: 1750.25,
            ),
            Order(
              id: '005',
              customerName: 'Carlos Souza',
              date: '2024-03-13',
              status: 'pendente',
              value: 950.00,
            ),
          ],
        ),
      );
    } catch (e) {
      return ApiResponse.error('Erro de conexão: ${e.toString()}');
    }
  }
}
