import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyTodo {
  final String id;
  final String task;
  final String email;
  final DateTime date;

  DailyTodo({required this.id, required this.task, required this.email, required this.date});


  Map<String, dynamic> toMap() => {"id":id, "task":task, "email": email, 'date':Timestamp.fromDate(date),};
}

