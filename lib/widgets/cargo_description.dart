import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

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

  @override
  void initState() {
    _weightController = TextEditingController();
    _widthController = TextEditingController();
    _heightController = TextEditingController();
    _lengthController = TextEditingController();
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
                    onChanged: (value) {},
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
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
                        onChanged: (value) {},
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
                        onChanged: (value) {},
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
                        onChanged: (value) {},
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
