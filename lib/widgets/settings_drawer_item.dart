import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../style.dart';

class SettingsDrawerItem extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  final String localeKey;
  const SettingsDrawerItem({
    @required this.iconData,
    @required this.onTap,
    @required this.localeKey,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: Style.primaryColor,
              size: 18,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              localeKey,
              style: TextStyle(
                color: Style.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
