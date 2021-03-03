import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/screens/choose_order_location_screen.dart';
import 'package:logos_new/widgets/add_comment_to_order.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:logos_new/widgets/cargo_description.dart';
import 'package:logos_new/widgets/primary_segmented_control.dart';
import 'package:logos_new/widgets/settings_drewer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../style.dart';

class CreateOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                              builder: (context) => ChooseOrderLocationScreen(
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
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Color(0xffE0E0E0),
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  LocaleKeys.create_order_where_from,
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
                    SizedBox(
                      height: 7,
                    ),
                    GestureDetector(
                      onTap: () {},
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
                                Text(
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
                onTap: () {},
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
                          Text(
                            LocaleKeys.create_order_as_soon_as_possible,
                            style: TextStyle(
                              fontSize: 14,
                              color: Style.primaryColor,
                              fontWeight: FontWeight.w500,
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
                            builder: (context) => ChooseOrderLocationScreen(
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
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Color(0xffE0E0E0),
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  LocaleKeys.create_order_where_from,
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
                    SizedBox(
                      height: 7,
                    ),
                    GestureDetector(
                      onTap: () {},
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
                                Text(
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
                onTap: () {},
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
                          Text(
                            LocaleKeys.create_order_as_soon_as_possible,
                            style: TextStyle(
                              fontSize: 14,
                              color: Style.primaryColor,
                              fontWeight: FontWeight.w500,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: double.infinity,
                height: 60,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.create_order_cost,
                      style: TextStyle(
                        fontSize: 18,
                        color: Style.primaryColor,
                      ),
                    ).tr(),
                    Text(
                      '500 ₴',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Style.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                onPressed: () async {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Style.secondaryColor,
                child: Text(
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
