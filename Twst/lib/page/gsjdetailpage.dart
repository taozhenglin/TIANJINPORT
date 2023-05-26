import 'package:flutter/cupertino.dart';

class GsjDetailPage extends StatelessWidget {
  final arguments;
  const GsjDetailPage({Key? key, required this.arguments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text('${arguments}'),
    );
  }
}
