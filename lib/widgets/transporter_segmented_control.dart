import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/transporter_orders_provider.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class TransporterOrdersSegmentedControl extends StatefulWidget {
  const TransporterOrdersSegmentedControl({
    Key key,
  }) : super(key: key);

  @override
  _TransporterOrdersSegmentedControlState createState() =>
      _TransporterOrdersSegmentedControlState();
}

class _TransporterOrdersSegmentedControlState
    extends State<TransporterOrdersSegmentedControl> {
  int _value;

  @override
  void initState() {
    _value = Provider.of<TransporterOrdersProvider>(context, listen: false)
            .currentTabIndex +
        1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final Map<dynamic, Widget> _children = {
      1: Container(
        child: Center(
            child: Text(
          LocaleKeys.my_orders_new_orders,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _value == 1
                ? Style.secondaryColor
                : Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ).tr()),
        width: (width - 30) / 2,
      ),
      2: Container(
        child: Center(
            child: Text(
          LocaleKeys.my_orders_active_orders,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _value == 2
                ? Style.secondaryColor
                : Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ).tr()),
        width: (width - 30) / 2,
      ),
      3: Container(
        child: Center(
            child: Text(
          LocaleKeys.my_orders_completed_orders,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _value == 3
                ? Style.secondaryColor
                : Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ).tr()),
        width: (width - 30) / 2,
      ),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: CupertinoSlidingSegmentedControl(
        thumbColor: Style.primaryColor,
        children: _children,
        onValueChanged: (value) {
          if (value == 1) {
            Provider.of<TransporterOrdersProvider>(context, listen: false)
                .setTabIndex(0);
          } else if (value == 2) {
            Provider.of<TransporterOrdersProvider>(context, listen: false)
                .setTabIndex(1);
          } else if (value == 3) {
            Provider.of<TransporterOrdersProvider>(context, listen: false)
                .setTabIndex(2);
          } else {}
          setState(() {
            _value = value;
          });
        },
        groupValue: _value,
      ),
    );
  }
}
