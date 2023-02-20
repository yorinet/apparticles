import 'package:flutter/material.dart';

class WTwoBox extends StatelessWidget {
  final Widget widgetFirst;
  final Widget? widgetLast;
  const WTwoBox({super.key, required this.widgetFirst, this.widgetLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: Colors.white24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widgetFirst,
          widgetLast!,
        ],
      ),
    );
  }
}
