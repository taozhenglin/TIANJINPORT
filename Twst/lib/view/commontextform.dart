import 'package:flutter/cupertino.dart';

class CommonTextForm extends StatelessWidget {
  final String title;
  final Color titlecolor;
  final double titleSize;
  final String content;
  final Color contentcolor;
  final double contentSize;
  final FontWeight? weight;

  const CommonTextForm({
    required this.title,
    required this.titlecolor,
    required this.titleSize,
    required this.content,
    required this.contentcolor,
    required this.contentSize,
    this.weight,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              color: titlecolor,
            ),
          ),
          Text(
            content,
            style: TextStyle(
                fontSize: contentSize, color: contentcolor, fontWeight: weight),
          ),
        ],
      ),
    );
  }
}
