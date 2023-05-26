import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double titleSize;
  final IconData? icon;
  final Color? iconColor;
  final Function onClick;

  CommonAppBar({
    required this.title,
    required this.titleSize,
    this.icon,
    this.iconColor,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          Center(
            child: Expanded(
                child: Text(
              title,
              style: TextStyle(fontSize: titleSize, color: Colors.black),
            )),
          ),
          Icon(
            icon,
            color: iconColor,
            size: 28,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
