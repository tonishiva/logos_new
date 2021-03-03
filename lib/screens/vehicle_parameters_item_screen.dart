import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/providers/references_provider.dart';
import 'package:logos_new/screens/choose_vehicle_screen.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class VehicleParametersItemScreen extends StatelessWidget {
  final String title;
  final bool isFutureBuilder;
  final bool isBodyType;
  final bool isMakeType;

  VehicleParametersItemScreen({
    @required this.title,
    @required this.isFutureBuilder,
    this.isBodyType = false,
    this.isMakeType = false,
  });
  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: !isFutureBuilder
          ? Padding(
              padding: EdgeInsets.all(30),
              child: ListView.builder(
                itemBuilder: (context, i) => GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (isBodyType) {
                      Provider.of<AuthProvider>(context, listen: false)
                          .setVehicleBodyType(Provider.of<ReferencesProvider>(
                                  context,
                                  listen: false)
                              .references['vehicles']['body-types'][i]);
                    } else {
                      Provider.of<AuthProvider>(context, listen: false)
                          .setVehicleLoadingType(
                              Provider.of<ReferencesProvider>(context,
                                      listen: false)
                                  .references['vehicles']['loadings'][i]);
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    child: Text(
                      isBodyType
                          ? Provider.of<ReferencesProvider>(context,
                                  listen: false)
                              .references['vehicles']['body-types'][i]['label']
                              .toString()
                              .toUpperCase()
                          : Provider.of<ReferencesProvider>(context,
                                  listen: false)
                              .references['vehicles']['loadings'][i]['label']
                              .toString()
                              .toUpperCase(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                itemCount: isBodyType
                    ? Provider.of<ReferencesProvider>(context, listen: false)
                        .references['vehicles']['body-types']
                        .length
                    : Provider.of<ReferencesProvider>(context, listen: false)
                        .references['vehicles']['loadings']
                        .length,
              ),
            )
          : FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Style.primaryColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        LocaleKeys.errors_general,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ).tr(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(30),
                    child: ListView.builder(
                      itemBuilder: (context, i) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (isMakeType) {
                            Provider.of<AuthProvider>(context, listen: false)
                                .setVehicleMakeType(Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .vehicleMakes[i]);
                          } else {
                            Provider.of<AuthProvider>(context, listen: false)
                                .setVehicleModelType(Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .vehicleModels[i]);
                          }
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          child: Text(
                            isMakeType
                                ? Provider.of<AuthProvider>(context)
                                    .vehicleMakes[i]['name']
                                    .toString()
                                    .toUpperCase()
                                : Provider.of<AuthProvider>(context)
                                    .vehicleModels[i]['name']
                                    .toString()
                                    .toUpperCase(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      itemCount: isMakeType
                          ? Provider.of<AuthProvider>(context)
                              .vehicleMakes
                              .length
                          : Provider.of<AuthProvider>(context)
                              .vehicleModels
                              .length,
                    ),
                  );
                }
              },
              future: isMakeType
                  ? Provider.of<AuthProvider>(context, listen: false)
                      .getVehicleMakes()
                  : Provider.of<AuthProvider>(context, listen: false)
                      .getVehicleModels(),
            ),
    );
  }
}
