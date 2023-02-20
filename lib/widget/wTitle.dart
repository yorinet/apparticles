import 'package:flutter/material.dart';

class WTitle extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final double? spaceTop;
  final double? spaceBottom;
  const WTitle({
    super.key,
    required this.text,
    this.size = 13,
    this.color = Colors.white,
    this.weight = FontWeight.normal,
    this.spaceTop = 0,
    this.spaceBottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: spaceTop!, bottom: spaceBottom!),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
        ),
      ),
    );
  }
}
