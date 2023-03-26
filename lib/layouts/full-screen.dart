import 'package:flutter/material.dart';

class FullScreenLayout extends StatelessWidget {
  final Widget body;
  const FullScreenLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body,
    );
  }
}
