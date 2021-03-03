import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/orders_provider.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:logos_new/widgets/primary_search_button.dart';
import 'package:logos_new/widgets/primary_segmented_control.dart';
import 'package:logos_new/widgets/settings_drewer.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class OrdersSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _orders = Provider.of<OrdersProvider>(context).orders;
    final _additionalLoadings =
        Provider.of<OrdersProvider>(context).additionalLoadings;
    final _isOrdersSelected =
        Provider.of<OrdersProvider>(context).isOrdersSelected;
    return Scaffold(
      drawerScrimColor: Color.fromRGBO(0, 0, 0, 0.5),
      drawer: Drawer(
        child: SettingsDrawer(),
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
      body: Column(
        children: [
          PrimarySearchButton(),
          SizedBox(
            height: 14,
          ),
          PrimarySegmentedControl(),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    _isOrdersSelected
                        ? _orders.isEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/illustrations/choose-role.svg',
                                      width: 133,
                                      height: 133,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      LocaleKeys.order_search_no_orders_title,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ).tr(),
                                    Text(
                                      LocaleKeys.order_search_no_orders_text,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                        fontSize: 14,
                                      ),
                                    ).tr(),
                                  ],
                                ),
                              )
                            : Container(
                                width: 0,
                                height: 0,
                              )
                        : _additionalLoadings.isEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/illustrations/choose-role.svg',
                                      width: 133,
                                      height: 133,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      LocaleKeys
                                          .order_search_no_additional_loadings_title,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ).tr(),
                                    Text(
                                      LocaleKeys
                                          .order_search_no_additional_loadings_text,
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                        fontSize: 14,
                                      ),
                                    ).tr(),
                                  ],
                                ),
                              )
                            : Container(
                                width: 0,
                                height: 0,
                              ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
