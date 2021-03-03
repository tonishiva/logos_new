import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/generated/locale_keys.g.dart';

import '../style.dart';

class PrimarySearchButton extends StatelessWidget {
  const PrimarySearchButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: () {},
          color: Style.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                CupertinoIcons.search,
                color: Colors.white,
                size: 14,
              ),
              Text(
                LocaleKeys.order_search_title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Style.secondaryColor,
                ),
              ).tr(),
              Container(
                width: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
