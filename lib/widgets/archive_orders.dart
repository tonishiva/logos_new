import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/detail_order_provider.dart';
import 'package:logos_new/providers/orders_search_provider.dart';
import 'package:logos_new/providers/sender_orders_provider.dart';
import 'package:logos_new/screens/sender_details_order.dart';
import 'package:logos_new/screens/transporter_detailed_order_screen.dart';
import 'package:logos_new/widgets/order_list_item.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArchiveOrdersList extends StatefulWidget {
  const ArchiveOrdersList({
    Key key,
  }) : super(key: key);

  @override
  _ArchiveOrdersListState createState() => _ArchiveOrdersListState();
}

class _ArchiveOrdersListState extends State<ArchiveOrdersList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    // monitor network fetch

    try {
      await Provider.of<SenderOrdersProvider>(context, listen: false)
          .getArchiveOrders(context: context, renew: true);
      _refreshController.refreshCompleted();
    } catch (error) {
      print(error);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(LocaleKeys.errors_general_short).tr(),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void _onLoading() async {
    // monitor network fetch
    try {
      _refreshController.loadNoData();
    } catch (error) {
      print(error);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(LocaleKeys.errors_general_short).tr(),
        duration: Duration(seconds: 2),
      ));
    }
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
  }

  @override
  Widget build(BuildContext context) {
    final _archiveOrders =
        Provider.of<SenderOrdersProvider>(context).archiveOrders;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: ClassicHeader(
        refreshingText: '',
        idleText: '',
        completeText: '',
        failedText: '',
        releaseText: '',
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("");
          } else {
            body = Text("");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: _archiveOrders.isEmpty
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
                          child: OrderListItem(
                            price: _archiveOrders[i]['general']['price_total'],
                            departureAt: _archiveOrders[i]['general']
                                ['departure_at'],
                            distance: _archiveOrders[i]['general']
                                ['distance_value'],
                            distanceUnits: _archiveOrders[i]['general']
                                ['distance_units'],
                            weight: _archiveOrders[i]['general']
                                    ['package_weight']
                                .toString(),
                            weightUnits: _archiveOrders[i]['general']
                                ['package_weight_units'],
                            addressFrom: _archiveOrders[i]['details']
                                ['label_from_marker'],
                            addressTo: _archiveOrders[i]['details']
                                ['label_to_marker'],
                            labelFrom: _archiveOrders[i]['general']
                                ['label_from'],
                            labelTo: _archiveOrders[i]['general']['label_to'],
                            onTap: () {
                              Provider.of<DetailOrderProvider>(context,
                                      listen: false)
                                  .setIsLoading(true);
                              Provider.of<DetailOrderProvider>(context,
                                      listen: false)
                                  .getOrder(
                                      context: context,
                                      orderId: _archiveOrders[i]['id']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SenderDetailedOrderScreen(
                                    labelFrom: _archiveOrders[i]['general']
                                        ['label_from'],
                                    labelTo: _archiveOrders[i]['general']
                                        ['label_to'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    childCount: _archiveOrders.length),
          ),
        ],
      ),
    );
  }
}
