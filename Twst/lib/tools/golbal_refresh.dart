import 'package:flutter/cupertino.dart';

abstract class GlobalKeyRefreshableWidget extends StatefulWidget {
  GlobalKeyRefreshableWidget({ required Key key})
      : super(key: key is GlobalKey ? key : GlobalKey());

  void reload() {
    if (key is! GlobalKey) {
      return;
    }
    final aKey = key as GlobalKey;
    // ignore: invalid_use_of_protected_member
    aKey.currentState?.setState(() {});
  }
}

class RefreshableStatefulWidget extends GlobalKeyRefreshableWidget {
  final Widget Function(BuildContext cntext) builder;

  RefreshableStatefulWidget({required Key key, required this.builder})
      : assert(builder != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RefreshableViewState(builder);
  }
}

class _RefreshableViewState extends State<RefreshableStatefulWidget> {
  final Widget Function(BuildContext cntext) builder;
  _RefreshableViewState(this.builder);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}

