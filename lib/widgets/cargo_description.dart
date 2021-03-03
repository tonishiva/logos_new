import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/providers/create_order_provider.dart';
import 'package:logos_new/providers/references_provider.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class CargoDescription extends StatefulWidget {
  const CargoDescription({
    Key key,
  }) : super(key: key);

  @override
  _CargoDescriptionState createState() => _CargoDescriptionState();
}

class _CargoDescriptionState extends State<CargoDescription> {
  TextEditingController _weightController;
  TextEditingController _widthController;
  TextEditingController _heightController;
  TextEditingController _lengthController;
  List<dynamic> _packageTypes;

  @override
  void initState() {
    _packageTypes = Provider.of<ReferencesProvider>(context, listen: false)
        .references['orders']['package-types']
        .map((e) => e['label'])
        .toList();
    print(_packageTypes);
    _weightController = TextEditingController(
      text: Provider.of<CreateOrderProvider>(context, listen: false)
                  .packageWeight !=
              null
          ? Provider.of<CreateOrderProvider>(context, listen: false)
              .packageWeight
              .toString()
          : null,
    );
    _widthController = TextEditingController(
        text: Provider.of<CreateOrderProvider>(context, listen: false)
                    .packageWidth !=
                null
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .packageWidth
                .toString()
            : null);
    _heightController = TextEditingController(
        text: Provider.of<CreateOrderProvider>(context, listen: false)
                    .packageHeight !=
                null
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .packageHeight
                .toString()
            : null);
    _lengthController = TextEditingController(
        text: Provider.of<CreateOrderProvider>(context, listen: false)
                    .packageLength !=
                null
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .packageLength
                .toString()
            : null);
    super.initState();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _lengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 8),
                  width: 120,
                  child: Text(
                    LocaleKeys.create_order_weight,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ).tr(),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    LocaleKeys.create_order_package_type,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                    ),
                  ).tr(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 100,
                  child: TextFormField(
                    controller: _weightController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      Provider.of<CreateOrderProvider>(context, listen: false)
                          .setPackageWeight(double.parse(value));
                    },
                    style: TextStyle(
                      color: Style.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.number,
                    cursorColor: Style.primaryColor,
                    decoration: InputDecoration(
                      counterText: '',
                      fillColor: Color(0xffF2F2F2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF9F9F9),
                    ),
                    child: DropdownButton(
                      underline: Container(
                        width: 0,
                        height: 0,
                      ),
                      isExpanded: true,
                      onChanged: (value) {
                        Provider.of<CreateOrderProvider>(context, listen: false)
                            .setPackageType(Provider.of<ReferencesProvider>(
                                    context,
                                    listen: false)
                                .references['orders']['package-types']
                                .singleWhere((e) => e['label'] == value)['key']);
                      },
                      icon: Icon(
                        CupertinoIcons.right_chevron,
                        size: 18,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                      value: Provider.of<CreateOrderProvider>(context)
                                  .packageType !=
                              null
                          ? Provider.of<ReferencesProvider>(context)
                              .references['orders']['package-types']
                              .singleWhere((e) =>
                                  e['key'] ==
                                  Provider.of<CreateOrderProvider>(context)
                                      .packageType)['label']
                          : _packageTypes[0],
                      items: _packageTypes
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(),
                    //     Icon(
                    //       CupertinoIcons.right_chevron,
                    //       size: 18,
                    //       color: Color.fromRGBO(0, 0, 0, 0.5),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                LocaleKeys.create_order_dimensions,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ).tr(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      child: TextFormField(
                        controller: _widthController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          Provider.of<CreateOrderProvider>(context,
                                  listen: false)
                              .setPackageWidth(double.parse(value));
                        },
                        style: TextStyle(
                          color: Style.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: Style.primaryColor,
                        decoration: InputDecoration(
                          counterText: '',
                          fillColor: Color(0xffF2F2F2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      LocaleKeys.vehicle_width,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ).tr(),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      child: TextFormField(
                        controller: _heightController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          Provider.of<CreateOrderProvider>(context,
                                  listen: false)
                              .setPackageHeight(double.parse(value));
                        },
                        style: TextStyle(
                          color: Style.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: Style.primaryColor,
                        decoration: InputDecoration(
                          counterText: '',
                          fillColor: Color(0xffF2F2F2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      LocaleKeys.vehicle_height,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ).tr(),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      child: TextFormField(
                        controller: _lengthController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          Provider.of<CreateOrderProvider>(context,
                                  listen: false)
                              .setPackageLength(double.parse(value));
                        },
                        style: TextStyle(
                          color: Style.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: Style.primaryColor,
                        decoration: InputDecoration(
                          counterText: '',
                          fillColor: Color(0xffF2F2F2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      LocaleKeys.vehicle_length,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                    ).tr(),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
