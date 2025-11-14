import 'package:flutter/material.dart';
import 'package:project/app.dart';
import 'package:project/service_locator.dart';

void main() {
  locator.allowReassignment = true;

  setupLocator();

  runApp(const MyApp());
}