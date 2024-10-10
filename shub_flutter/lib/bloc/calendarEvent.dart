// calendar_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // Thêm thư viện Material để sử dụng BuildContext

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class SelectDateEvent extends CalendarEvent {
  final BuildContext context;

  const SelectDateEvent(this.context);

  @override
  List<Object?> get props => [context];
}
