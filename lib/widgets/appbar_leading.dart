import 'package:flutter/material.dart';

import '../style.dart';

class AppBarLeading extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  const AppBarLeading({
    @required this.icon,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(229, 229, 229, 0.5),
                offset: Offset(0, 4),
                blurRadius: 5,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Style.primaryColor,
            size: 24,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
