import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText;
  final String title;

  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5), // Khoảng cách giữa title và TextFormField
            TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              controller: controller,
              keyboardType: keyboardType,
              autofocus: true,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.black12,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15), // Điều chỉnh chiều cao của TextFormField
              ),
            ),
          ],
        ),
      ),
    );
  }
}
