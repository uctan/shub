import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Thêm thư viện này để sử dụng FilteringTextInputFormatter
import 'package:shub_flutter/task4.dart';
import 'package:shub_flutter/widget/custom_calender.dart';
import 'package:shub_flutter/widget/custom_pillar.dart';
import 'package:shub_flutter/widget/custom_textfied.dart';

class DesignedUI extends StatefulWidget {
  const DesignedUI({super.key});

  @override
  _DesignedUIState createState() => _DesignedUIState();
}

class _DesignedUIState extends State<DesignedUI> {
  // Create TextEditingControllers
  final TextEditingController dateController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController pillarController = TextEditingController();
  final TextEditingController doanhthuController = TextEditingController();
  final TextEditingController dongiaController = TextEditingController();

  // Hàm kiểm tra
  void _validateInputs() {
    if (dateController.text.isEmpty ||
        quantityController.text.isEmpty ||
        pillarController.text.isEmpty ||
        doanhthuController.text.isEmpty ||
        dongiaController.text.isEmpty) {
      _showDialog(
        title: 'Error',
        message: 'Vui lòng điền đủ thông tin.',
        actionButtonTitle: 'OK',
        actionButtonTextStyle: const TextStyle(color: Colors.red),
      );
    } else if (!_isNumeric(quantityController.text) ||
        !_isNumeric(doanhthuController.text) ||
        !_isNumeric(dongiaController.text)) {
      _showDialog(
        title: 'Error',
        message: 'Vui lòng chỉ nhập số cho số lượng, doanh thu và đơn giá.',
        actionButtonTitle: 'OK',
        actionButtonTextStyle: const TextStyle(color: Colors.red),
      );
    } else {
      _showDialog(
        title: 'Success',
        message: 'Thông tin đang được upload',
        actionButtonTitle: 'Ok',
        actionButtonTextStyle: const TextStyle(color: Colors.green),
      );
    }
  }

  // Hàm kiểm tra xem chuỗi có phải là số hay không
  bool _isNumeric(String str) {
    return RegExp(r'^-?[0-9]+$').hasMatch(str);
  }

  // Thông tin dialog
  void _showDialog({
    required String title,
    required String message,
    required String actionButtonTitle,
    required TextStyle actionButtonTextStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                actionButtonTitle,
                style: actionButtonTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 40, right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DataStructure(),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  'Đóng',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 20),
                              child: ElevatedButton(
                                onPressed: _validateInputs,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text('Cập nhật'),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Nhập Giao Dịch',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCalendar(
                          controller: dateController,
                          hintText: 'Ngày giờ',
                          title: 'Thời gian',
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: quantityController,
                          keyboardType:
                              TextInputType.number, // Hiển thị bàn phím số
                          hintText: 'Nhập số lượng',
                          title: 'Số lượng',
                        ),
                        SizedBox(height: 20),
                        CustomPillar(
                          controller: pillarController,
                          hintText: 'Trụ',
                          title: 'Vui lòng chọn',
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: doanhthuController,
                          keyboardType:
                              TextInputType.number, // Hiển thị bàn phím số
                          hintText: 'Doanh thu',
                          title: 'Vui lòng nhập doanh thu',
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: dongiaController,
                          keyboardType:
                              TextInputType.number, // Hiển thị bàn phím số
                          hintText: 'Đơn giá',
                          title: 'Vui lòng nhập đơn giá',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
