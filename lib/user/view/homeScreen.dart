import 'package:flutter/material.dart';
import 'package:dailytask/common/table_calendar.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tableCalendarScreen(),
    );
  }
}

