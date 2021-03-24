import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/detail_order_provider.dart';
import 'package:logos_new/providers/transporter_orders_provider.dart';
import 'package:logos_new/providers/user_provider.dart';
import 'package:logos_new/screens/my_orders_screen.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:logos_new/widgets/map_header.dart';
import 'package:logos_new/widgets/map_panel_transporter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../style.dart';

class TransporterDetailedOrderScreen extends StatelessWidget {
  final String labelFrom;
  final String labelTo;
  const TransporterDetailedOrderScreen(
      {@required this.labelFrom, @required this.labelTo});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<DetailOrderProvider>(
      builder: (context, data, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFAFAFA),
          elevation: 4,
          iconTheme: IconThemeData(
            color: Color(0xff242A38),
          ),
          leading: Builder(
            builder: (context) => AppBarLeading(
              icon: Icons.arrow_back_ios_outlined,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            LocaleKeys.detailed_order_title,
            style: TextStyle(
              color: Style.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
        ),
        body: data.isLoading
            ? Center(
                child: SpinKitFadingCircle(
                  color: Style.primaryColor,
                  size: 50,
                ),
              )
            : data.order.isEmpty
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : Builder(
                    builder: (context) => Stack(
                      children: [
                        SlidingUpPanel(
                          maxHeight: height - kToolbarHeight,
                          minHeight: height - kToolbarHeight - 353,
                          body: MapHeader(
                            routePoints: data.routePoints,
                            latFrom: data.order['general']['markers']['from']
                                ['lat'],
                            lonFrom: data.order['general']['markers']['from']
                                ['lon'],
                            latTo: data.order['general']['markers']['to']
                                ['lat'],
                            lonTo: data.order['general']['markers']['to']
                                ['lon'],
                          ),
                          panelBuilder: (ScrollController sc) => Container(
                            color: Color(0xffFAFAFA),
                            padding: EdgeInsets.all(14),
                            child: CustomScrollView(
                              controller: sc,
                              slivers: [
                                MapPanelTransporter(
                                    order: data.order,
                                    labelFrom: labelFrom,
                                    labelTo: labelTo)
                              ],
                            ),
                          ),
                        ),
                        data.order['status'] == 'new'
                            ? Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  color: Color(0xffFAFAFA),
                                  width: width,
                                  height: 100,
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, bottom: 40, top: 10),
                                  child: RaisedButton(
                                    disabledColor: Color(0xffECECEC),
                                    elevation: 0,
                                    onPressed: () async {
                                      data.setIsButtonLoading(true);
                                      try {
                                        await data.acceptOrder(
                                          context: context,
                                          vehicleId: Provider.of<UserProvider>(
                                                  context,
                                                  listen: false)
                                              .userVehicles[0]['id'],
                                        );
                                        data.setIsButtonLoading(false);
                                        data.clearData();
                                        Provider.of<TransporterOrdersProvider>(
                                                context,
                                                listen: false)
                                            .setLoading(true);
                                        Provider.of<TransporterOrdersProvider>(
                                                context,
                                                listen: false)
                                            .getAllLists(context: context);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MyOrdersScreen(
                                              isSender:
                                                  Provider.of<UserProvider>(
                                                              context)
                                                          .user['roles'][0] ==
                                                      'sender',
                                            ),
                                          ),
                                          (route) => route.isFirst,
                                        );
                                      } catch (e) {
                                        print(e);
                                        data.setIsButtonLoading(false);
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              LocaleKeys.errors_general,
                                            ).tr(),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Style.secondaryColor,
                                    child: data.isButtonLoading
                                        ? SpinKitThreeBounce(
                                            color: Style.primaryColor,
                                            size: 25.0,
                                          )
                                        : Text(
                                            LocaleKeys
                                                .detailed_order_take_order,
                                            style: TextStyle(
                                              color: Style.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ).tr(),
                                  ),
                                ),
                              )
                            : Container(
                                width: 0,
                                height: 0,
                              ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
