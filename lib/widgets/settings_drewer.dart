import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/providers/create_order_provider.dart';
import 'package:logos_new/providers/logged_state_provider.dart';
import 'package:logos_new/providers/orders_search_provider.dart';
import 'package:logos_new/providers/sender_orders_provider.dart';
import 'package:logos_new/providers/transporter_orders_provider.dart';
import 'package:logos_new/providers/user_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/screens/create_order_screen.dart';
import 'package:logos_new/screens/my_orders_screen.dart';
import 'package:logos_new/screens/orders_search_screen.dart';
import 'package:logos_new/widgets/settings_drawer_item.dart';
import 'package:provider/provider.dart';

import '../style.dart';
import '../globals.dart' as globals;

class SettingsDrawer extends StatelessWidget {
  final bool isMyOrdersScreen;
  const SettingsDrawer({
    @required this.isMyOrdersScreen,
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
                    if (!isMyOrdersScreen) {
                      Navigator.pop(context);
                    } else {
                      Provider.of<TransporterOrdersProvider>(context,
                              listen: false)
                          .clearData();
                      Provider.of<OrdersSearchProvider>(context, listen: false)
                          .setLoading(true);
                      Provider.of<OrdersSearchProvider>(context, listen: false)
                          .getOpenedOrders(context: context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersSearchScreen()),
                        (route) => route.isFirst,
                      );
                    }
                  },
                  localeKey: LocaleKeys.drawer_order_search,
                )
              : SettingsDrawerItem(
                  iconData: CupertinoIcons.cube_box,
                  onTap: () {
                    if (!isMyOrdersScreen) {
                      Navigator.pop(context);
                    } else {
                      Provider.of<SenderOrdersProvider>(context, listen: false)
                          .clearData();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateOrderScreen()),
                        (route) => route.isFirst,
                      );
                    }
                  },
                  localeKey: LocaleKeys.drawer_create_order,
                ),
          SettingsDrawerItem(
            iconData: CupertinoIcons.doc_plaintext,
            onTap: () {
              if (isMyOrdersScreen) {
                Navigator.pop(context);
              } else {
                if (_user['roles'][0] == 'sender') {
                  Provider.of<CreateOrderProvider>(context, listen: false)
                      .clearData();
                  Provider.of<SenderOrdersProvider>(context, listen: false)
                      .setLoading(true);
                  Provider.of<SenderOrdersProvider>(context, listen: false)
                      .getAllLists(context: context);
                } else {
                  Provider.of<TransporterOrdersProvider>(context, listen: false)
                      .setLoading(true);
                  Provider.of<TransporterOrdersProvider>(context, listen: false)
                      .getAllLists(context: context);
                }
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOrdersScreen(
                      isSender: _user['roles'][0] == 'sender',
                    ),
                  ),
                  (route) => route.isFirst,
                );
              }
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
              showDialog(
                context: context,
                child: LogoutAlertDialog(),
              );
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

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoading = Provider.of<AuthProvider>(context).isLoading;
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(LocaleKeys.primary_cancel).tr(),
        ),
        TextButton(
          onPressed: () async {
            Provider.of<AuthProvider>(context, listen: false).setLoading(true);
            try {
              globals.clearSessionData(context);
              await Provider.of<AuthProvider>(context, listen: false)
                  .logout(context: context);
              Provider.of<LoggedStateProvider>(context, listen: false)
                  .setIsAuth(false);
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            } catch (error) {
              print(error);
            }
          },
          child: Text(LocaleKeys.primary_ok).tr(),
        ),
      ],
      title: Text(LocaleKeys.logout_dialog_title).tr(),
      content: _isLoading
          ? Container(
              height: 30,
              child: SpinKitThreeBounce(
                color: Style.primaryColor,
                size: 30,
              ),
            )
          : null,
    );
  }
}
