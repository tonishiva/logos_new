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
    final _openedOrders = Provider.of<OrdersProvider>(context).openedOrders;
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
                  delegate: _isOrdersSelected
                      ? _openedOrders.isEmpty
                          ? SliverChildListDelegate([
                              Container(
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
                            ])
                          : SliverChildBuilderDelegate(
                              (context, i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 5,
                                            color: Color.fromRGBO(
                                                229, 229, 229, 0.5),
                                          ),
                                        ],
                                      ),
                                      child: Center(child: Text('${_openedOrders[i]['general']['label_from']} - ${_openedOrders[i]['general']['label_to']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),),
                                    ),
                                  ),
                              childCount: _openedOrders.length)
                      : SliverChildListDelegate([
                          Container(
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
