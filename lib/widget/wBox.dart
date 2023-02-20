import 'package:flutter/material.dart';

class WBox extends StatelessWidget {
  final Widget widget;
  final double? height;
  final double? padHorizontal;
  const WBox({
    super.key,
    required this.widget,
    this.height = 48,
    this.padHorizontal = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      margin: const EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.symmetric(horizontal: padHorizontal!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: Colors.white24)),
      child: widget,
    );
  }
}
