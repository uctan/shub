import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shub_flutter/bloc/calendarBloc.dart';
import 'package:shub_flutter/bloc/calendarEvent.dart';
import 'package:shub_flutter/bloc/calendarState.dart';

class CustomCalendar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String title;

  const CustomCalendar({
    super.key,
    this.controller,
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
        padding: const EdgeInsets.only(left: 12, top: 5, right: 12),
        child: Row(
          children: [
            Expanded(
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
                  SizedBox(height: 5),
                  BlocListener<CalendarBloc, CalendarState>(
                    listener: (context, state) {
                      // Cập nhật giá trị cho controller
                      if (state.selectedDateTime.isNotEmpty) {
                        controller?.text = state.selectedDateTime;
                      }
                    },
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                context.read<CalendarBloc>().add(SelectDateEvent(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
