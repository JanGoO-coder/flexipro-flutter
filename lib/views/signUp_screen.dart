import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flexipro/views/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstController = TextEditingController();

  final TextEditingController lastController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  String _selectedOption;

  String baseUrl = 'http://10.0.2.2:8000/api/auth/register';

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedOption = ''; // Set the default selected option
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Color(0xFF009CBF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset('assets/images/logo.png'),
              TextField(
                controller: firstController,
                decoration: InputDecoration(
                  labelText: 'First Name',
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
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: lastController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
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
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16.0),
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
              SizedBox(height: 16),
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
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
              SizedBox(height: 10),
              Row(
                children: [
                  Radio(
                    value: 'employee',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  Text('User'),
                  Radio(
                    value: 'company',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  Text('Company'),
                ],
              ),
              SizedBox(height: 24.0),
              Container(
                width: double
                    .maxFinite, // Set the width to occupy the available space
                child: ElevatedButton(
                  onPressed: () {
                    postData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE78200),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void postData() async {
    try {
      var body = {
        'first_name': firstController.text,
        'last_name': lastController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'c_password': confirmController.text,
        'user_role': _selectedOption.toString()
      };

      final response = await Dio().post(
        baseUrl,
        data: body,
      );

      if (response.statusCode == 500) {
        // Handle successful response
        print('Request Sucessfull with status code: ${response.statusCode}');
        // print(response.data);
      } else {
        // Handle error response
        print('Request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors
      print('Error: $error');
    }
  }
}
