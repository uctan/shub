import 'package:flutter/material.dart';

class CustomPillar extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText;
  final String title;

  const CustomPillar({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    required this.title,
  });

  @override
  _CustomPillarState createState() => _CustomPillarState();
}

class _CustomPillarState extends State<CustomPillar> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 5, right: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedValue,
                    hint: Text(widget.hintText),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                        widget.controller.text = newValue ?? "";
                      });
                    },
                    items: <String>['Trụ 1', 'Trụ 2']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.black12,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
