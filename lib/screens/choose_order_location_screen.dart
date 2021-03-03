import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/widgets/appbar_leading.dart';

import '../style.dart';

class ChooseOrderLocationScreen extends StatefulWidget {
  final bool isOrigin;

  const ChooseOrderLocationScreen({
    @required this.isOrigin,
  });

  @override
  _ChooseOrderLocationScreenState createState() =>
      _ChooseOrderLocationScreenState();
}

class _ChooseOrderLocationScreenState extends State<ChooseOrderLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerScrimColor: Color.fromRGBO(0, 0, 0, 0.5),
        appBar: AppBar(
          backgroundColor: Color(0xffFAFAFA),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xff242A38),
          ),
          leading: Builder(
            builder: (context) => AppBarLeading(
              icon: Icons.close,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            widget.isOrigin
                ? LocaleKeys.create_order_load
                : LocaleKeys.create_order_unload,
            style: TextStyle(
              color: Style.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
        ),
        body: Container());
  }
}
