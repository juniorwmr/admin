import 'package:admin/models/order.dart';

class DashboardData {
  final int totalProducts;
  final int totalGroups;
  final int monthlyOrders;
  final int activeCustomers;
  final List<Order> recentOrders;

  DashboardData({
    required this.totalProducts,
    required this.totalGroups,
    required this.monthlyOrders,
    required this.activeCustomers,
    required this.recentOrders,
  });
}
