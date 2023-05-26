import 'package:flutter/cupertino.dart';

class CommonUpDownTextItem extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final String count;
  final double countSize;
  final Color countColor;
  final VoidCallback onPressed;

  const CommonUpDownTextItem({
    required this.text,
    required this.textSize,
    required this.textColor,
    required this.onPressed,
    required this.count,
    required this.countSize,
    required this.countColor,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(fontSize: countSize, color: countColor),
          ),
          Text(
            text,
            style: TextStyle(fontSize: textSize, color: textColor),
          ),
        ],
      ),
    );
  }
}
