import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/create_order_provider.dart';
import 'package:logos_new/providers/sender_orders_provider.dart';
import 'package:logos_new/screens/create_order_date_screen.dart';
import 'package:logos_new/screens/create_order_location_screen.dart';
import 'package:logos_new/screens/create_order_sender_receiver_screen.dart';
import 'package:logos_new/screens/my_orders_screen.dart';
import 'package:logos_new/widgets/add_comment_to_order.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:logos_new/widgets/cargo_description.dart';
import 'package:logos_new/widgets/primary_segmented_control.dart';
import 'package:logos_new/widgets/settings_drewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class CreateOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _order = Provider.of<CreateOrderProvider>(context);
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
          LocaleKeys.drawer_create_order,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimarySegmentedControl(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: double.infinity,
                height: 38,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Style.secondaryColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.cube_box,
                      color: Style.primaryColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      LocaleKeys.create_order_origin,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Container(
                height: 124,
                width: double.infinity,
                padding: EdgeInsets.all(
                  8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      color: Color.fromRGBO(236, 236, 236, 0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateOrderLocationScreen(
                                    isOrigin: true,
                                  )),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF9F9F9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: Color(0xffE0E0E0),
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: _order.originAddress != null
                                          ? Text(
                                              _order.originAddress,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Style.primaryColor,
                                              ),
                                            )
                                          : Text(
                                              LocaleKeys
                                                  .create_order_where_from,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.5),
                                              ),
                                            ).tr(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: Icon(
                                CupertinoIcons.right_chevron,
                                size: 18,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CreateOrderSenderReceiverScreen(
                              isSender: true,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF9F9F9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  color: Color(0xffE0E0E0),
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                _order.useSenderCredentials != null
                                    ? _order.useSenderCredentials == false
                                        ? Text(
                                            LocaleKeys.create_order_me,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Style.primaryColor,
                                            ),
                                          ).tr()
                                        : Text(
                                            '${_order.senderName} ${_order.senderSurname}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Style.primaryColor,
                                            ),
                                          )
                                    : Text(
                                        LocaleKeys.create_order_sender,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                        ),
                                      ).tr(),
                              ],
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 18,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (_order.departureAt != null) {
                    _order.setTemporarySelectedDate(_order.departureAt);
                  } else {
                    _order.setTemporarySelectedDate(DateTime.now());
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateOrderDateScreen(
                        isDeparture: true,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        color: Color.fromRGBO(236, 236, 236, 0.5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xffE0E0E0),
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          _order.departureAt != null
                              ? Text(
                                  '${DateFormat('d MMMM yyyy - HH:mm', EasyLocalization.of(context).locale.toLanguageTag()).format(_order.departureAt)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Style.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  LocaleKeys.create_order_date_time,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ).tr(),
                        ],
                      ),
                      Icon(
                        CupertinoIcons.right_chevron,
                        size: 18,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: double.infinity,
                height: 38,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Style.secondaryColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.cube_box,
                      color: Style.primaryColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      LocaleKeys.create_order_destination,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Container(
                height: 124,
                width: double.infinity,
                padding: EdgeInsets.all(
                  8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      color: Color.fromRGBO(236, 236, 236, 0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateOrderLocationScreen(
                              isOrigin: false,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF9F9F9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: Color(0xffE0E0E0),
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: _order.destinationAddress != null
                                          ? Text(
                                              _order.destinationAddress,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Style.primaryColor,
                                              ),
                                            )
                                          : Text(
                                              LocaleKeys.create_order_where_to,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.5),
                                              ),
                                            ).tr(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: Icon(
                                CupertinoIcons.right_chevron,
                                size: 18,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CreateOrderSenderReceiverScreen(
                              isSender: false,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF9F9F9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  color: Color(0xffE0E0E0),
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                _order.useReceiverCredentials != null
                                    ? _order.useReceiverCredentials == false
                                        ? Text(
                                            LocaleKeys.create_order_me,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Style.primaryColor,
                                            ),
                                          ).tr()
                                        : Text(
                                            '${_order.receiverName} ${_order.receiverSurname}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Style.primaryColor,
                                            ),
                                          )
                                    : Text(
                                        LocaleKeys.create_order_receiver,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                        ),
                                      ).tr(),
                              ],
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 18,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (_order.arrivalBefore != null) {
                    _order.setTemporarySelectedDate(_order.arrivalBefore);
                  } else {
                    if (_order.departureAt != null) {
                      _order.setTemporarySelectedDate(_order.departureAt);
                    } else {
                      _order.setTemporarySelectedDate(DateTime.now());
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateOrderDateScreen(
                        isDeparture: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        color: Color.fromRGBO(236, 236, 236, 0.5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xffE0E0E0),
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          _order.arrivalBefore != null
                              ? Text(
                                  '${DateFormat('d MMMM yyyy - HH:mm', EasyLocalization.of(context).locale.toLanguageTag()).format(_order.arrivalBefore)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Style.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  LocaleKeys.create_order_date_time,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ).tr(),
                        ],
                      ),
                      Icon(
                        CupertinoIcons.right_chevron,
                        size: 18,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: double.infinity,
                height: 38,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Style.secondaryColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.cube_box,
                      color: Style.primaryColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      LocaleKeys.create_order_cargo_description,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ],
                ),
              ),
            ),
            CargoDescription(),
            SizedBox(
              height: 10,
            ),
            AddCommentToOrder(),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: RaisedButton(
                disabledColor: Color(0xffECECEC),
                elevation: 0,
                onPressed: _order.arrivalBefore == null ||
                        _order.useSenderCredentials == null ||
                        _order.useReceiverCredentials == null ||
                        _order.departureAt == null ||
                        _order.latFrom == null ||
                        _order.latTo == null ||
                        _order.lonFrom == null ||
                        _order.lonTo == null ||
                        _order.packageType == null ||
                        _order.packageWeight == null ||
                        _order.packageWidth == null ||
                        _order.packageLength == null ||
                        _order.packageHeight == null ||
                        _order.packageWeight == 0 ||
                        _order.packageWidth == 0 ||
                        _order.packageLength == 0 ||
                        _order.packageHeight == 0 ||
                        _order.arrivalBefore.isBefore(_order.departureAt)
                    ? null
                    : () async {
                        _order.setLoading(true);
                        try {
                          await _order.createOrder(context: context);
                          _order.clearData(notify: true);
                          Provider.of<SenderOrdersProvider>(context,
                                  listen: false)
                              .setLoading(true);
                          Provider.of<SenderOrdersProvider>(context,
                                  listen: false)
                              .getAllLists(context: context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrdersScreen(
                                        isSender: true,
                                      )),
                              (route) => route.isFirst);
                        } catch (error) {
                          _order.setLoading(false);
                          print(error);
                        }
                      },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Style.secondaryColor,
                child: _order.isLoading
                    ? SpinKitThreeBounce(
                        color: Style.primaryColor,
                        size: 25.0,
                      )
                    : Text(
                        LocaleKeys.create_order_complete_order,
                        style: TextStyle(
                          color: Style.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ).tr(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
