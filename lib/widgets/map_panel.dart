import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/generated/locale_keys.g.dart';

import '../style.dart';

class MapPanel extends StatelessWidget {
  final Map<String, dynamic> order;
  final String labelFrom;
  final String labelTo;
  const MapPanel({
    @required this.order,
    @required this.labelFrom,
    @required this.labelTo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            height: 75,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(229, 229, 229, 0.5),
                  offset: Offset(0, 4),
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.place_outlined,
                                size: 14,
                                color: Style.primaryColor,
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Text(
                                labelFrom,
                                style: TextStyle(
                                  color: Style.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.place_outlined,
                                size: 14,
                                color: Style.secondaryColor,
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Text(
                                labelTo,
                                style: TextStyle(
                                  color: Style.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        left: 27,
                        top: 17,
                        child: Container(
                          width: 1,
                          height: 10,
                          color: Style.primaryColor,
                        ))
                  ],
                ),
                Container(
                  height: 75,
                  width: 81,
                  decoration: BoxDecoration(
                    color: Style.secondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${double.parse(order['general']['price_total']).round()} ₴',
                        style: TextStyle(
                          color: Style.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${double.parse(order['general']['distance_value']).round()} ${order['general']['distance_units']}',
                        style: TextStyle(
                          color: Style.greyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(229, 229, 229, 0.5),
                  offset: Offset(0, 4),
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 14,
                        color: Style.primaryColor,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.detailed_order_load,
                              style: TextStyle(
                                color: Style.greyColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ).tr(),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Text(
                                order['details']['label_from_marker'],
                                style: TextStyle(
                                  color: Style.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Color(0xffA0A0A0),
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${DateFormat('dd/MM/y - HH:mm', EasyLocalization.of(context).locale.toLanguageTag()).format(DateTime.parse(order['general']['departure_at']))}',
                                  style: TextStyle(
                                    color: Style.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  color: Color(0xffA0A0A0),
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  order['general']['use_sender_credentials'] ==
                                          false
                                      ? '${order['users']['sender']['first_name']} ${order['users']['sender']['last_name']}'
                                      : '${order['general']['sender_cred_name']} ${order['general']['sender_cred_surname']}',
                                  style: TextStyle(
                                    color: Color(0xffA0A0A0),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.phone_iphone_rounded,
                                      color: Color(0xffA0A0A0),
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      order['general']
                                                  ['use_sender_credentials'] ==
                                              false
                                          ? '${order['users']['sender']['phones'][0]['number']}'
                                          : '${order['general']['sender_cred_phone']}',
                                      style: TextStyle(
                                        color: Color(0xffA0A0A0),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffF2F2F2)),
                                  child: Icon(
                                    Icons.phone,
                                    color: Style.greyColor,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 14,
                        color: Style.secondaryColor,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.detailed_order_unload,
                              style: TextStyle(
                                color: Style.greyColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ).tr(),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Text(
                                order['details']['label_to_marker'],
                                style: TextStyle(
                                  color: Style.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Color(0xffA0A0A0),
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${DateFormat('dd/MM/y - HH:mm', EasyLocalization.of(context).locale.toLanguageTag()).format(DateTime.parse(order['general']['arrival_before']))}',
                                  style: TextStyle(
                                    color: Style.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  color: Color(0xffA0A0A0),
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  order['general']
                                              ['use_receiver_credentials'] ==
                                          false
                                      ? '${order['users']['sender']['first_name']} ${order['users']['sender']['last_name']}'
                                      : '${order['general']['receiver_cred_name']} ${order['general']['receiver_cred_surname']}',
                                  style: TextStyle(
                                    color: Color(0xffA0A0A0),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.phone_iphone_rounded,
                                      color: Color(0xffA0A0A0),
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      order['general'][
                                                  'use_receiver_credentials'] ==
                                              false
                                          ? '${order['users']['sender']['phones'][0]['number']}'
                                          : '${order['general']['receiver_cred_phone']}',
                                      style: TextStyle(
                                        color: Color(0xffA0A0A0),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffF2F2F2)),
                                  child: Icon(
                                    Icons.phone,
                                    color: Style.greyColor,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(229, 229, 229, 0.5),
                  offset: Offset(0, 4),
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.cube_box,
                        color: Color(0xffA0A0A0),
                        size: 14,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.detailed_order_package_type,
                              style: TextStyle(
                                color: Style.greyColor,
                                fontSize: 12,
                              ),
                            ).tr(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${order['details']['label_package_type']}',
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.work_outline,
                        color: Color(0xffA0A0A0),
                        size: 14,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.detailed_order_weight,
                              style: TextStyle(
                                color: Style.greyColor,
                                fontSize: 12,
                              ),
                            ).tr(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${order['general']['package_weight']}${order['general']['package_weight_units']}',
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.square_foot,
                        color: Color(0xffA0A0A0),
                        size: 14,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.detailed_order_dimensions,
                              style: TextStyle(
                                color: Style.greyColor,
                                fontSize: 12,
                              ),
                            ).tr(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${order['general']['package_depth']} x ${order['general']['package_width']} x ${order['general']['package_height']}',
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }
}
