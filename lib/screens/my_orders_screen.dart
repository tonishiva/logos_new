import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/sender_orders_provider.dart';
import 'package:logos_new/providers/transporter_orders_provider.dart';
import 'package:logos_new/widgets/active_orders.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:logos_new/widgets/archive_orders.dart';
import 'package:logos_new/widgets/completed_orders.dart';
import 'package:logos_new/widgets/new_orders.dart';
import 'package:logos_new/widgets/ongoing_orders.dart';
import 'package:logos_new/widgets/pending_orders.dart';
import 'package:logos_new/widgets/sender_segmented_control.dart';
import 'package:logos_new/widgets/settings_drewer.dart';
import 'package:logos_new/widgets/transporter_segmented_control.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class MyOrdersScreen extends StatelessWidget {
  static const routeName = 'test';
  final bool isSender;

  const MyOrdersScreen({
    @required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    final bool _isLoading = isSender
        ? Provider.of<SenderOrdersProvider>(context).isLoading
        : Provider.of<TransporterOrdersProvider>(context).isLoading;
    return Scaffold(
      drawerScrimColor: Color.fromRGBO(0, 0, 0, 0.5),
      drawer: Drawer(
        child: SettingsDrawer(
          isMyOrdersScreen: true,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffFAFAFA),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff242A38),
        ),
        leading: Builder(
          builder: (context) => AppBarLeading(
            icon: Icons.dehaze,
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.my_orders_title,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: _isLoading
          ? Center(
              child: SpinKitFadingCircle(
                color: Style.primaryColor,
                size: 50,
              ),
            )
          : Column(
              children: [
                isSender
                    ? SenderOrdersSegmentedControl()
                    : TransporterOrdersSegmentedControl(),
                SizedBox(
                  height: 10,
                ),
                OrdersContent(
                  isSender: isSender,
                ),
              ],
            ),
    );
  }
}

class OrdersContent extends StatelessWidget {
  final bool isSender;
  const OrdersContent({
    @required this.isSender,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IndexedStack(
        index: isSender
            ? Provider.of<SenderOrdersProvider>(context).currentTabIndex
            : Provider.of<TransporterOrdersProvider>(context).currentTabIndex,
        children: isSender
            ? [
                PendingOrdersList(),
                OngoingOrdersList(),
                ArchiveOrdersList(),
              ]
            : [
                NewOrdersList(),
                ActiveOrdersList(),
                CompletedOrdersList(),
              ],
      ),
    );
  }
}
