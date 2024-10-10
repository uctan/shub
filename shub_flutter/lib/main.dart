import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shub_flutter/bloc/calendarBloc.dart';
import 'package:shub_flutter/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: BlocProvider(
        create: (context) => CalendarBloc(),
        child: DesignedUI(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
