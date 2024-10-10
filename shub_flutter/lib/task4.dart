import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataStructure extends StatefulWidget {
  @override
  _DataStructureState createState() => _DataStructureState();
}

class _DataStructureState extends State<DataStructure> {
  String? token;
  List<int>? data;
  List<Map<String, dynamic>>? queries;
  List<int> results = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse('https://test-share.shub.edu.vn/api/intern-test/input'));
      print('ket qua t ra ve tu api API: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          token = jsonResponse['token'];
          data = List<int>.from(jsonResponse['data']);
          queries = List<Map<String, dynamic>>.from(jsonResponse['query']);
          errorMessage = '';
        });
        print('Token: $token');
        print('Data: $data');
        print('Queries: $queries');
        processQueries();
      } else {
        setState(() {
          errorMessage = 'loi khi load data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Loi: $e';
      });
      print('loi fetc data $e');
    }
  }

  void processQueries() {
    if (data != null && queries != null) {
      // Khởi tạo danh sách để lưu tổng dồn, kích thước là chiều dài của data + 1
      List<int> prefixSum = List.filled(data!.length + 1, 0);
      //tinh tông dồn cho cac danh sach
      for (int i = 0; i < data!.length; i++) {
        prefixSum[i + 1] = prefixSum[i] + data![i];
      }
      // truy van trong danh sach queries

      for (var query in queries!) {
        int l = query['range'][0];
        int r = query['range'][1];
        if (query['type'] == "1") {
          int total = prefixSum[r + 1] - prefixSum[l];
          results.add(total);
        } else if (query['type'] == "2") {
          int totalEven = 0;
          int totalOdd = 0;
          // Lặp qua từng chỉ số trong khoảng từ l đến r
          for (int i = l; i <= r; i++) {
            if (i % 2 == 0) {
              totalEven += data![i];
            } else {
              totalOdd += data![i];
            }
          }
          // Tính hiệu giữa tổng chẵn và tổng lẻ, thêm vào danh sách results
          results.add(totalEven - totalOdd);
        }
      }
      print('ke qua queries: $results');
      sendResults();
    }
  }

  Future<void> sendResults() async {
    try {
      final response = await http.post(
        Uri.parse('https://test-share.shub.edu.vn/api/intern-test/output'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(results),
      );
      print('gui ket qua ${jsonEncode({'results': results})}');

      if (response.statusCode == 200) {
        print('ket qua gui thanh cong ${response.statusCode}');
      } else {
        throw Exception('ket qua gui that bai: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Loi sending $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Query App')),
      body: results.isEmpty
          ? Center(
              child: errorMessage.isNotEmpty
                  ? Text(errorMessage)
                  : CircularProgressIndicator())
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text('Kết quả truy vấn ${index + 1}: ${results[index]}'),
                );
              },
            ),
    );
  }
}
