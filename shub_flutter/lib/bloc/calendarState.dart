// calendar_state.dart
import 'package:equatable/equatable.dart';

class CalendarState extends Equatable {
  final String selectedDateTime;

  const CalendarState({required this.selectedDateTime});

  factory CalendarState.initial() {
    return const CalendarState(selectedDateTime: '');
  }

  CalendarState copyWith({String? selectedDateTime}) {
    return CalendarState(
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
    );
  }

  @override
  List<Object?> get props => [selectedDateTime];
}
