import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../style.dart';

class OrderListItem extends StatelessWidget {
  final String price;
  final String departureAt;
  final String distance;
  final String distanceUnits;
  final String weight;
  final String weightUnits;
  final String labelFrom;
  final String labelTo;
  final String addressFrom;
  final String addressTo;
  final Function onTap;

  const OrderListItem({
    @required this.addressFrom,
    @required this.addressTo,
    @required this.labelFrom,
    @required this.labelTo,
    @required this.distance,
    @required this.distanceUnits,
    @required this.weight,
    @required this.weightUnits,
    @required this.departureAt,
    @required this.price,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 14),
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 5,
                  color: Color.fromRGBO(229, 229, 229, 0.5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Color(0xffECECEC),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${DateFormat('y/MM/dd HH:mm', EasyLocalization.of(context).locale.toLanguageTag()).format(DateTime.parse(departureAt))}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${double.parse(distance).round()}$distanceUnits/$weight$weightUnits',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 12,
                      color: Style.primaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          labelFrom,
                          style: TextStyle(
                            color: Style.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            addressFrom,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Style.greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 12,
                      color: Style.secondaryColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          labelTo,
                          style: TextStyle(
                            color: Style.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            addressTo,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Style.greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              height: 37,
              decoration: BoxDecoration(
                color: Style.secondaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  '${double.parse(price).round()} ₴',
                  style: TextStyle(
                    color: Style.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 63,
            right: 23,
            child: Icon(
              CupertinoIcons.forward,
              size: 24,
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
          ),
          Positioned(
            child: Container(
              height: 12.5,
              width: 1,
              color: Style.primaryColor,
            ),
            top: 64.5,
            left: 25.5,
          )
        ],
      ),
    );
  }
}
