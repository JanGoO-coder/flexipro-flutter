import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flexipro/views/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import './companyAdmin/CompDashboard_screen.dart';
import './employee/employeeDashboard_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String baseUrl = 'http://10.0.2.2:8000/api/auth/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Color(0xFF009CBF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE78200),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Sign In'),
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text('Create an Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 500) {
        // Login successful
        final userRole = responseData['user_role'];
        navigateToDashboard(userRole);
      } else {
        // Login failed
        final errorMessage = responseData['message'];
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Login Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred'),
          content: Text('Failed to sign in. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void navigateToDashboard(String userRole) {
    switch (userRole) {
      case 'company':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CompanyAdminDashboard()),
        );
        break;
      case 'employee':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmployeeDashboardScreen()),
        );
        break;
      default:
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Role Error'),
            content: Text('Invalid user role received from the server.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
    }
  }
}
