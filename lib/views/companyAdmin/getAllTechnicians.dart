import 'package:flutter/material.dart';

import '../services/getAllTechnicians.dart';

class GetAllTechnicians extends StatefulWidget {
  const GetAllTechnicians({Key key}) : super(key: key);

  @override
  State<GetAllTechnicians> createState() => _GetAllTechniciansState();
}

class _GetAllTechniciansState extends State<GetAllTechnicians> {
  String _data = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Technicians'),
      ),
      body: Column(
        children: [],
      ),
    );
  }

  Future<void> _fetchData() async {
    final ApiService apiService = ApiService();
    final http.Response response = await apiService.getRequest('data');

    if (response.statusCode == 200) {
      setState(() {
        _data = response.body;
        _isLoading = false;
      });
    } else {
      setState(() {
        _data = 'Error: ${response.statusCode}';
        _isLoading = false;
      });
    }
  }
}
