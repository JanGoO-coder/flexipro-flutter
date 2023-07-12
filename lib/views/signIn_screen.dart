import 'package:fluttertoast/fluttertoast.dart';
import 'package:flexipro/views/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import './companyAdmin/CompDashboard_screen.dart';
import './employee/employeeDashboard_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  onPressed: () {
                    if (emailController.text.isEmpty &&
                        emailController.text.isEmail) {
                      showMessage('Email is empty or incorrect');
                      return;
                    } else if (passwordController.text.isEmpty &&
                        passwordController.text.length >= 8) {
                      showMessage('Please enter correct password');
                      return;
                    } else {
                      postData();
                    }
                  },
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

  void postData() async {
    try {
      var body = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      final response = await Dio().post(
        baseUrl,
        data: body,
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final tokePref = prefs.setString('token', token);
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

        final role = decodedToken['user_role'];
        final rolePref = prefs.setString('role', role);
        if (decodedToken['user_role'] == 'employee') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmployeeDashboardScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CompanyAdminDashboard()),
          );
        }
        ;
      } else {
        print('reject');
        return;
      }
    } catch (e) {
      showMessage('Undefined user');
    }
  }

  showMessage(msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
