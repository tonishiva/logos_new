import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/screens/choose_documents_screen.dart';
import 'package:logos_new/screens/vehicle_parameters_item_screen.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class ChooseVehicleScreen extends StatefulWidget {
  @override
  _ChooseVehicleScreenState createState() => _ChooseVehicleScreenState();
}

class _ChooseVehicleScreenState extends State<ChooseVehicleScreen> {
  TextEditingController _widthController;
  TextEditingController _heightController;
  TextEditingController _lengthController;

  @override
  void initState() {
    _widthController = TextEditingController();
    _heightController = TextEditingController();
    _lengthController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    _lengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bodyType = Provider.of<AuthProvider>(context).vehicleBodyType;
    final _loadingType = Provider.of<AuthProvider>(context).vehicleLoadingType;
    final _make = Provider.of<AuthProvider>(context).vehicleMake;
    final _model = Provider.of<AuthProvider>(context).vehicleModel;
    final _capacity = Provider.of<AuthProvider>(context).vehicleCapacity;

    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xffFAFAFA),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff242A38),
        ),
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Icon(
            CupertinoIcons.back,
            size: 28,
          ),
          onTap: () {
            Provider.of<AuthProvider>(context, listen: false)
                .clearVehicleParametersStep();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.create_account_step6,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 5,
                  color: Color.fromRGBO(229, 229, 229, 0.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.vehicle_type_title,
                    style: TextStyle(
                      color: Style.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ).tr(),
                  SizedBox(
                    height: 15,
                  ),
                  _bodyType != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            LocaleKeys.vehicle_body_type,
                            style: TextStyle(fontSize: 12),
                          ).tr(),
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  VehicleParametersItem(
                    title: _bodyType,
                    localeKey: LocaleKeys.vehicle_body_type,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleParametersItemScreen(
                            isFutureBuilder: false,
                            title: LocaleKeys.vehicle_body_type,
                            isBodyType: true,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  _make != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            LocaleKeys.vehicle_make,
                            style: TextStyle(fontSize: 12),
                          ).tr(),
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  VehicleParametersItem(
                    title: _make,
                    localeKey: LocaleKeys.vehicle_make,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleParametersItemScreen(
                            isFutureBuilder: true,
                            title: LocaleKeys.vehicle_make,
                            isMakeType: true,
                          ),
                        ),
                      );
                    },
                  ),
                  _make != null
                      ? SizedBox(
                          height: 9,
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  _make != null && _model != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            LocaleKeys.vehicle_model,
                            style: TextStyle(fontSize: 12),
                          ).tr(),
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  _make != null
                      ? VehicleParametersItem(
                          title: _model,
                          localeKey: LocaleKeys.vehicle_model,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VehicleParametersItemScreen(
                                  isFutureBuilder: true,
                                  title: LocaleKeys.vehicle_model,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  SizedBox(
                    height: 9,
                  ),
                  _loadingType != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            LocaleKeys.vehicle_loading_type,
                            style: TextStyle(fontSize: 12),
                          ).tr(),
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
                  VehicleParametersItem(
                    title: _loadingType,
                    localeKey: LocaleKeys.vehicle_loading_type,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleParametersItemScreen(
                            isFutureBuilder: false,
                            title: LocaleKeys.vehicle_loading_type,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      LocaleKeys.vehicle_carrying_capacity,
                      style: TextStyle(fontSize: 12),
                    ).tr(),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffFAFAFA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '$_capacity',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 1,
                    ),
                    child: Slider(
                      min: 500,
                      max: 22000,
                      onChanged: (value) {
                        Provider.of<AuthProvider>(context, listen: false)
                            .setVehicleCapacity(value.round());
                      },
                      value: _capacity.truncateToDouble(),
                      activeColor: Style.secondaryColor,
                      inactiveColor: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.vehicle_min_kg,
                        style: TextStyle(fontSize: 14),
                      ).tr(),
                      Text(
                        LocaleKeys.vehicle_max_kg,
                        style: TextStyle(fontSize: 14),
                      ).tr()
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      LocaleKeys.vehicle_body_dimensions,
                      style: TextStyle(fontSize: 12),
                    ).tr(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: TextFormField(
                                controller: _lengthController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  setState(() {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setVehicleLength(
                                      int.parse(value),
                                    );
                                  });
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
                                  fillColor: Color(0xffF9F9F9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.vehicle_length,
                              style: TextStyle(fontSize: 12),
                            ).tr(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.center,
                                controller: _heightController,
                                onChanged: (value) {
                                  setState(() {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setVehicleHeight(
                                      int.parse(value),
                                    );
                                  });
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
                                  fillColor: Color(0xffF9F9F9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.vehicle_height,
                              style: TextStyle(fontSize: 12),
                            ).tr(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: TextFormField(
                                controller: _widthController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  setState(() {
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setVehicleWidth(
                                      int.parse(value),
                                    );
                                  });
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
                                  fillColor: Color(0xffF9F9F9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              LocaleKeys.vehicle_width,
                              style: TextStyle(fontSize: 12),
                            ).tr(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      disabledColor: Color(0xffECECEC),
                      elevation: 0,
                      onPressed: Provider.of<AuthProvider>(context)
                                      .vehicleHeight ==
                                  null ||
                              Provider.of<
                                          AuthProvider>(context)
                                      .vehicleLength ==
                                  null ||
                              Provider.of<
                                          AuthProvider>(context)
                                      .vehicleWidth ==
                                  null ||
                              Provider.of<AuthProvider>(context)
                                      .vehicleHeight ==
                                  0 ||
                              Provider.of<
                                          AuthProvider>(context)
                                      .vehicleLength ==
                                  0 ||
                              Provider.of<AuthProvider>(context).vehicleWidth ==
                                  0 ||
                              Provider.of<
                                          AuthProvider>(context)
                                      .vehicleBodyType ==
                                  null ||
                              Provider.of<AuthProvider>(context)
                                      .vehicleLoadingType ==
                                  null ||
                              Provider.of<AuthProvider>(context).vehicleModel ==
                                  null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseDocumentsScreen(),
                                ),
                              );
                            },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Style.secondaryColor,
                      child: Text(
                        LocaleKeys.primary_continue,
                        style: TextStyle(
                            color: Style.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ).tr(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VehicleParametersItem extends StatelessWidget {
  const VehicleParametersItem({
    Key key,
    @required this.title,
    this.localeKey,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final String localeKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title != null
                ? Text(
                    title,
                    style: TextStyle(fontSize: 14),
                  )
                : Text(
                    localeKey,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ).tr(),
            Icon(
              Icons.chevron_right,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
