import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/providers/user_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/widgets/settings_drawer_item.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
        left: 22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Style.primaryColor,
                ),
                child: Center(
                  child: Text(
                    _user['first_name'][0].toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 22,
              ),
              Text(
                '${_user['first_name']} ${_user['last_name']}',
                style: TextStyle(
                  color: Style.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          _user['roles'][0] == 'transporter'
              ? SettingsDrawerItem(
                  iconData: CupertinoIcons.cube_box,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  localeKey: LocaleKeys.drawer_order_search,
                )
              : SettingsDrawerItem(
                  iconData: CupertinoIcons.cube_box,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  localeKey: LocaleKeys.drawer_create_order,
                ),
          SettingsDrawerItem(
            iconData: CupertinoIcons.doc_plaintext,
            onTap: () {
              Navigator.pop(context);
            },
            localeKey: LocaleKeys.drawer_my_orders,
          ),
          SettingsDrawerItem(
            onTap: () {
              Navigator.pop(context);
            },
            iconData: Icons.payment,
            localeKey: LocaleKeys.drawer_payments,
          ),
          SettingsDrawerItem(
            iconData: CupertinoIcons.exclamationmark_circle,
            onTap: () {
              Navigator.pop(context);
            },
            localeKey: LocaleKeys.drawer_about,
          ),
          SettingsDrawerItem(
            iconData: CupertinoIcons.lightbulb,
            onTap: () {
              Navigator.pop(context);
            },
            localeKey: LocaleKeys.drawer_whats_new,
          ),
          SettingsDrawerItem(
            iconData: Icons.support_agent,
            localeKey: LocaleKeys.drawer_feedback,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SettingsDrawerItem(
            iconData: CupertinoIcons.gear,
            localeKey: LocaleKeys.drawer_settings,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: SizedBox(),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .logout(context: context);
              // Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.square_arrow_left,
                  size: 18,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  LocaleKeys.drawer_exit,
                  style: TextStyle(
                    height: 16 / 14,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ).tr(),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
