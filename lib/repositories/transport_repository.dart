import 'package:flutter/material.dart';
import '../models/transport_overview.dart';
import '../models/transport_expense.dart';

class TransportRepository {
  final bool mock;
  TransportRepository({this.mock = true});

  Future<TransportOverview> fetchOverview() async {
    // TODO: replace with API call
    await Future.delayed(const Duration(milliseconds: 300));
    return const TransportOverview(
      totalBalance: 7783.00,
      totalExpense: -1187.40,
      goalAmount: 20000.00,
    );
  }

  // Returns a map of month name -> expenses
  Future<Map<String, List<TransportExpense>>> fetchExpensesByMonth() async {
    // TODO: replace with API call
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      'March': const [
        TransportExpense(
          title: 'Fuel',
          time: '18:27 - March 30',
          amount: '-\$3.53',
          icon: Icons.local_gas_station,
        ),
        TransportExpense(
          title: 'Car Parts',
          time: '15:00 - March 30',
          amount: '-\$26.75',
          icon: Icons.build,
        ),
      ],
      'February': const [
        TransportExpense(
          title: 'New Tires',
          time: '12:47 - February 10',
          amount: '-\$373.99',
          icon: Icons.tire_repair,
        ),
        TransportExpense(
          title: 'Car Wash',
          time: '9:30 - February 09',
          amount: '-\$9.74',
          icon: Icons.local_car_wash,
        ),
        TransportExpense(
          title: 'Public Transport',
          time: '7:50 - February 01',
          amount: '-\$1.24',
          icon: Icons.directions_bus,
        ),
      ],
    };
  }

  // Generic category overview (mock). Replace with API by category id.
  Future<TransportOverview> fetchOverviewByCategory({required int categoryId, required String name}) async {
    if (!mock) return fetchOverview();
    await Future.delayed(const Duration(milliseconds: 250));
    // Simple varied numbers by id for demo
    final base = 7000 + (categoryId * 10);
    final expense = -1000.0 - (categoryId * 3);
    return TransportOverview(
      totalBalance: base.toDouble(),
      totalExpense: expense,
      goalAmount: 20000.0,
    );
  }

  Future<Map<String, List<TransportExpense>>> fetchExpensesByMonthByCategory({
    required int categoryId,
    required String name,
  }) async {
    if (!mock) return fetchExpensesByMonth();
    await Future.delayed(const Duration(milliseconds: 250));
    IconData pickIcon() {
      final key = name.toLowerCase();
      if (key.contains('food')) return Icons.restaurant;
      if (key.contains('medicine')) return Icons.medical_services;
      if (key.contains('grocer')) return Icons.local_grocery_store;
      if (key.contains('rent')) return Icons.home_work_outlined;
      if (key.contains('gift')) return Icons.card_giftcard;
      if (key.contains('saving')) return Icons.savings;
      if (key.contains('entertain')) return Icons.movie_creation_outlined;
      if (key.contains('transport')) return Icons.directions_bus;
      return Icons.category;
    }

    final icon = pickIcon();
    return {
      'March': [
        TransportExpense(
          title: name == 'Transport' ? 'Fuel' : '$name 1',
          time: '18:27 - March 30',
          amount: '-\$3.53',
          icon: icon,
        ),
        TransportExpense(
          title: name == 'Transport' ? 'Car Parts' : '$name 2',
          time: '15:00 - March 30',
          amount: '-\$26.75',
          icon: icon,
        ),
      ],
      'February': [
        TransportExpense(
          title: name == 'Transport' ? 'New Tires' : '$name A',
          time: '12:47 - February 10',
          amount: '-\$373.99',
          icon: icon,
        ),
        TransportExpense(
          title: name == 'Transport' ? 'Car Wash' : '$name B',
          time: '9:30 - February 09',
          amount: '-\$9.74',
          icon: icon,
        ),
        TransportExpense(
          title: name == 'Transport' ? 'Public Transport' : '$name C',
          time: '7:50 - February 01',
          amount: '-\$1.24',
          icon: icon,
        ),
      ],
    };
  }
}
