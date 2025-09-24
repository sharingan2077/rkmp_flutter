import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GifScreen extends StatelessWidget {
  const GifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/images/animation.gif', fit: BoxFit.contain,));
  }
}
