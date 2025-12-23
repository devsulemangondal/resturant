import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Color(0xffE2E8F0),
            Colors.transparent,
          ],
        )));
  }
}
