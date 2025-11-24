// Service: ApiService
// Centralized HTTP client, token handling and endpoints.

import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/category.dart';
import '../models/transaction.dart';

class ApiService {
  ApiService({Dio? dio, String? baseUrl, bool mock = true})
      : _baseUrl = baseUrl ?? 'https://a63f923336f4.ngrok-free.app',
        _mock = mock,
        _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl ?? 'https://a63f923336f4.ngrok-free.app'));

  final Dio _dio;
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
    final res = await _dio.post(
      '/authen',
      data: {
        'username': email,
        'password': password,
      },
      options: Options(headers: _headers(withAuth: false)),
    );
    if (res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300) {
      final body = res.data;
      if (body is Map<String, dynamic>) {
        final token = body['token'] as String? ?? '';
        _token = token;
        final userJson = body['user'] is Map<String, dynamic>
            ? body['user'] as Map<String, dynamic>
            : body;
        return User.fromJson(userJson, token: token);
      }
      // Fallback: construct a minimal user
      final token = '';
      _token = token;
      return User.fromJson({'id': 0, 'name': '', 'email': email}, token: token);
    }
    throw Exception(_extractError(res));
  }

  Future<void> signup({required String username, required String dob, required String password}) async {
    if (_mock) {
      await Future.delayed(const Duration(milliseconds: 400));
      return;
    }
    final res = await _dio.post(
      '/api/v1/users/signup',
      data: {'username': username, 'dob': dob, 'password': password},
      options: Options(headers: _headers(withAuth: false)),
    );
    if (res.statusCode == null || res.statusCode! < 200 || res.statusCode! >= 300) {
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
    final res = await _dio.get(
      '$_baseUrl/categories',
      options: Options(headers: _headers()),
    );
    if (res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300) {
      final body = res.data;
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
    final res = await _dio.get(
      '$_baseUrl/transactions',
      options: Options(headers: _headers()),
    );
    if (res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300) {
      final body = res.data;
      final list = body is List
          ? body
          : (body is Map && body['data'] is List ? body['data'] : []);
      return (list as List)
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception(_extractError(res));
  }

  Future<void> createTransaction(TransactionModel tx) async {
    if (_mock) {
      await Future.delayed(const Duration(milliseconds: 300));
      return;
    }
    final res = await _dio.post(
      '$_baseUrl/transactions',
      data: tx.toJson(),
      options: Options(headers: _headers()),
    );
    if (res.statusCode == null || res.statusCode! < 200 || res.statusCode! >= 300) {
      throw Exception(_extractError(res));
    }
  }

  String _extractError(Response res) {
    try {
      final body = res.data;
      if (body is Map && body['message'] is String) return body['message'] as String;
      if (body is Map && body['error'] is String) return body['error'] as String;
    } catch (_) {}
    final code = res.statusCode;
    return 'HTTP ${code ?? 'unknown'}';
  }
}
