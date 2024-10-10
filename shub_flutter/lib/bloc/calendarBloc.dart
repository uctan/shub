import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shub_flutter/bloc/calendarEvent.dart';
import 'package:shub_flutter/bloc/calendarState.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final DateFormat _dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm');

  CalendarBloc() : super(CalendarState.initial()) {
    on<SelectDateEvent>(_onSelectDate);
  }

  Future<void> _onSelectDate(
    SelectDateEvent event,
    Emitter<CalendarState> emit,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: event.context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        emit(state.copyWith(
          selectedDateTime: _dateTimeFormat.format(pickedDateTime),
        ));
      }
    }
  }
}
