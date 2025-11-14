// Service: ApiService
// Centralized HTTP client, token handling and endpoints.

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/category.dart';
import '../models/transaction.dart';

class ApiService {
  ApiService({http.Client? client, String? baseUrl, bool mock = true})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? 'https://api.example.com',
        _mock = mock;

  final http.Client _client;
  final String _baseUrl;
  final bool _mock;

  String? _token;
  set token(String? value) => _token = value;
  String? get tokenValue => _token;

  Map<String, String> _headers({bool withAuth = true}) {
    return {
      'Content-Type': 'application/json',
      if (withAuth && _token != null) 'Authorization': 'Bearer $_token',
    };
  }

  // Auth
  Future<User> login({required String email, required String password}) async {
    if (_mock) {
      await Future.delayed(const Duration(milliseconds: 400));
      final token = 'mock-token-123';
      _token = token;
      return User.fromJson({'id': 1, 'name': 'Mock User', 'email': email}, token: token);
    }
    final res = await _client.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: _headers(withAuth: false),
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final token = data['token'] as String? ?? '';
      _token = token;
      final user = User.fromJson(data['user'] as Map<String, dynamic>, token: token);
      return user;
    }
    throw Exception(_extractError(res));
  }

  Future<void> signup({required String name, required String email, required String password}) async {
    if (_mock) {
      await Future.delayed(const Duration(milliseconds: 400));
      return;
    }
    final res = await _client.post(
      Uri.parse('$_baseUrl/auth/signup'),
      headers: _headers(withAuth: false),
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception(_extractError(res));
    }
  }

  // Categories
  Future<List<Category>> getCategories() async {
    if (_mock) {
      await Future.delayed(const Duration(milliseconds: 400));
      final mock = [
        {
          'id': 1,
          'name': 'Food',
          'icon': 'restaurant',
          'color': '#5B9EFF'
        },
        {
          'id': 2,
          'name': 'Transport',
          'icon': 'directions_bus',
          'color': '#5B9EFF'
        },
        {
          'id': 3,
          'name': 'Medicine',
          'icon': 'local_pharmacy',
          'color': '#5B9EFF'
        },
        {
          'id': 4,
          'name': 'Groceries',
          'icon': 'shopping_bag',
          'color': '#5B9EFF'
        },
        {
          'id': 5,
          'name': 'Rent',
          'icon': 'home_work',
          'color': '#5B9EFF'
        },
        {
          'id': 6,
          'name': 'Gifts',
          'icon': 'card_giftcard',
          'color': '#5B9EFF'
        },
        {
          'id': 7,
          'name': 'Savings',
          'icon': 'savings',
          'color': '#5B9EFF'
        },
        {
          'id': 8,
          'name': 'Entertainment',
          'icon': 'movie',
          'color': '#5B9EFF'
        },
        {
          'id': 9,
          'name': 'More',
          'icon': 'add',
          'color': '#5B9EFF'
        },
      ];
      return mock.map((e) => Category.fromJson(e)).toList();
    }
    final res = await _client.get(
      Uri.parse('$_baseUrl/categories'),
      headers: _headers(),
    );
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      if (body is List) {
        return body.map((e) => Category.fromJson(e as Map<String, dynamic>)).toList();
      }
      if (body is Map && body['data'] is List) {
        return (body['data'] as List).map((e) => Category.fromJson(e as Map<String, dynamic>)).toList();
      }
      return [];
    }
    throw Exception(_extractError(res));
  }


  // Transactions
  Future<List<TransactionModel>> getTransactions() async {
    if (_mock) {
      await Future.delayed(const Duration(milliseconds: 400));
      final list = [
        {
          'id': 1,
          'categoryId': 1,
          'title': 'Lunch',
          'amount': 12.5,
          'createdAt': DateTime.now().toIso8601String(),
        },
        {
          'id': 2,
          'categoryId': 2,
          'title': 'Fuel',
          'amount': 40,
          'createdAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        }
      ];
      return list.map((e) => TransactionModel.fromJson(e)).toList();
    }
    final res = await _client.get(
      Uri.parse('$_baseUrl/transactions'),
      headers: _headers(),
    );
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      final list = body is List ? body : (body is Map && body['data'] is List ? body['data'] : []);
      return (list as List).map((e) => TransactionModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception(_extractError(res));
  }

  Future<void> createTransaction(TransactionModel tx) async {
    if (_mock) {
      await Future.delayed(const Duration(milliseconds: 300));
      return;
    }
    final res = await _client.post(
      Uri.parse('$_baseUrl/transactions'),
      headers: _headers(),
      body: jsonEncode(tx.toJson()),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception(_extractError(res));
    }
  }

  String _extractError(http.Response res) {
    try {
      final body = jsonDecode(res.body);
      if (body is Map && body['message'] is String) return body['message'] as String;
      if (body is Map && body['error'] is String) return body['error'] as String;
    } catch (_) {}
    return 'HTTP ${res.statusCode}';
  }
}
