import 'package:flutter/material.dart';

class DailyTodo {
  DailyTodo({required this.id, required this.task, required this.email});

  final String id;
  final String task;
  final String email;

  Map<String, dynamic> toMap() => {"id":id, "task":task, "email": email };
}

