import 'package:flutter/cupertino.dart';

class GsjDetailBorrowPage extends StatelessWidget {
  final num;
  const GsjDetailBorrowPage({Key? key, required this.num}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text('${num}'),
    );
  }
}
