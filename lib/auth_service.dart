import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthService {
  Future<void> login(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('https://reqres.in/api/login');

    try {
      // Kirim permintaan POST ke API
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Login berhasil
        final data = jsonDecode(response.body);
        final token = data['token'];
        debugPrint('Login successful! Token: $token');

        // Navigasi ke halaman HomePage
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Login gagal
        final error = jsonDecode(response.body)['error'];
        _showErrorDialog(context, error);
      }
    } catch (e) {
      // Tangani kesalahan jaringan
      _showErrorDialog(context, 'An error occurred. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
