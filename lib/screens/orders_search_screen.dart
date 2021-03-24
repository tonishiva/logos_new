import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/orders_search_provider.dart';
import 'package:logos_new/widgets/additional_loadings_list.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:logos_new/widgets/orders_list.dart';
import 'package:logos_new/widgets/primary_search_button.dart';
import 'package:logos_new/widgets/primary_segmented_control.dart';
import 'package:logos_new/widgets/settings_drewer.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class OrdersSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _isLoading = Provider.of<OrdersSearchProvider>(context).isLoading;
    return Scaffold(
      drawerScrimColor: Color.fromRGBO(0, 0, 0, 0.5),
      drawer: Drawer(
        child: SettingsDrawer(
          isMyOrdersScreen: false,
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
          LocaleKeys.order_search_title,
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
                PrimarySearchButton(),
                SizedBox(
                  height: 14,
                ),
                PrimarySegmentedControl(),
                SizedBox(
                  height: 10,
                ),
                Content(),
              ],
            ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isOrdersSelected =
        Provider.of<OrdersSearchProvider>(context).isOrdersSelected;
    return Expanded(
      child: IndexedStack(
        index: _isOrdersSelected ? 0 : 1,
        children: [
          OrdersList(),
          AdditionalLoadingsList(),
        ],
      ),
    );
  }
}
