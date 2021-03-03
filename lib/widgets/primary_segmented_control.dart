import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/orders_provider.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class PrimarySegmentedControl extends StatefulWidget {
  const PrimarySegmentedControl({
    Key key,
  }) : super(key: key);

  @override
  _PrimarySegmentedControlState createState() =>
      _PrimarySegmentedControlState();
}

class _PrimarySegmentedControlState extends State<PrimarySegmentedControl> {
  int _value;

  @override
  void initState() {
    if (Provider.of<OrdersProvider>(context, listen: false).isOrdersSelected) {
      _value = 1;
    } else {
      _value = 2;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final Map<dynamic, Widget> _children = {
      1: Container(
        child: Center(
            child: Text(
          LocaleKeys.order_search_orders,
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
          LocaleKeys.order_search_additional_loadings,
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
    };
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: CupertinoSlidingSegmentedControl(
        thumbColor: Style.primaryColor,
        children: _children,
        onValueChanged: (value) {
          setState(() {
            _value = value;
            Provider.of<OrdersProvider>(context, listen: false)
                .setIsOrdersSelected(value == 2 ? false : true);
          });
        },
        groupValue: _value,
      ),
    );
  }
}
