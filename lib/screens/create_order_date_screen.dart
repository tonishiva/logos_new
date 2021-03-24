import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/create_order_provider.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../style.dart';

class CreateOrderDateScreen extends StatelessWidget {
  final bool isDeparture;

  const CreateOrderDateScreen({
    @required this.isDeparture,
  });

  @override
  Widget build(BuildContext context) {
    final _order = Provider.of<CreateOrderProvider>(context);
    ScrollController _hoursController = FixedExtentScrollController(
      initialItem: isDeparture
          ? _order.departureAt != null
              ? _order.departureAt.hour
              : _order.temporarySelectedDate.hour
          : _order.arrivalBefore != null
              ? _order.arrivalBefore.hour
              : _order.temporarySelectedDate.hour,
    );
    ScrollController _minutesController = FixedExtentScrollController(
      initialItem: isDeparture
          ? _order.departureAt != null
              ? _order.departureAt.minute
              : _order.temporarySelectedDate.minute
          : _order.arrivalBefore != null
              ? _order.arrivalBefore.minute
              : _order.temporarySelectedDate.minute,
    );
    return Scaffold(
      drawerScrimColor: Color.fromRGBO(0, 0, 0, 0.5),
      appBar: AppBar(
        backgroundColor: Color(0xffFAFAFA),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xff242A38),
        ),
        leading: Builder(
          builder: (context) => AppBarLeading(
            icon: Icons.close,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          isDeparture
              ? LocaleKeys.create_order_load
              : LocaleKeys.create_order_unload,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    onPressed: () async {
                      final DateTime _pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: isDeparture
                            ? _order.departureAt != null
                                ? _order.departureAt
                                : DateTime.now()
                            : _order.arrivalBefore != null
                                ? _order.arrivalBefore
                                : _order.departureAt != null
                                    ? _order.departureAt
                                    : DateTime.now(),
                        lastDate: DateTime(2100),
                        locale: EasyLocalization.of(context).locale,
                      );
                      if (_pickedDate != null) {
                        _order.setTemporarySelectedDate(_pickedDate);
                      }
                    },
                    child: Text(
                      LocaleKeys.create_order_choose_date,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ).tr(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Text(
                    isDeparture
                        ? _order.departureAt != null
                            ? '${DateFormat('d MMMM yyyy', EasyLocalization.of(context).locale.toLanguageTag()).format(_order.departureAt)}'
                            : _order.temporarySelectedDate != null
                                ? '${DateFormat('d MMMM yyyy', EasyLocalization.of(context).locale.toLanguageTag()).format(_order.temporarySelectedDate)}'
                                : ''
                        : _order.arrivalBefore != null
                            ? '${DateFormat('d MMMM yyyy', EasyLocalization.of(context).locale.toLanguageTag()).format(_order.arrivalBefore)}'
                            : _order.temporarySelectedDate != null
                                ? '${DateFormat('d MMMM yyyy', EasyLocalization.of(context).locale.toLanguageTag()).format(_order.temporarySelectedDate)}'
                                : '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Style.primaryColor,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.create_order_choose_time,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(0, 0, 0, 0.5)),
                  ).tr(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        width: 43,
                        height: 36,
                        child: CupertinoPicker(
                          scrollController: _hoursController,
                          backgroundColor: Color.fromRGBO(118, 118, 128, 0.12),
                          children: [
                            for (var i = 0; i < 24; i += 1) Text('$i')
                          ],
                          itemExtent: 28,
                          onSelectedItemChanged: (value) {
                            _order.setTemporarySelectedDate(
                              DateTime(
                                  _order.temporarySelectedDate.year,
                                  _order.temporarySelectedDate.month,
                                  _order.temporarySelectedDate.day,
                                  value),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          ':',
                          style: TextStyle(
                            color: Style.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        width: 43,
                        height: 36,
                        child: CupertinoPicker(
                          scrollController: _minutesController,
                          backgroundColor: Color.fromRGBO(118, 118, 128, 0.12),
                          children: [
                            for (var i = 0; i < 60; i += 1) Text('$i')
                          ],
                          itemExtent: 28,
                          onSelectedItemChanged: (value) {
                            _order.setTemporarySelectedDate(
                              DateTime(
                                  _order.temporarySelectedDate.year,
                                  _order.temporarySelectedDate.month,
                                  _order.temporarySelectedDate.day,
                                  _order.temporarySelectedDate.hour,
                                  value),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: RaisedButton(
                disabledColor: Color(0xffECECEC),
                elevation: 0,
                onPressed: () {
                  if (isDeparture) {
                    _order.setDepartureAt(_order.temporarySelectedDate);
                  } else {
                    _order.setArrivalBefore(_order.temporarySelectedDate);
                  }
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Style.secondaryColor,
                child: Text(
                  LocaleKeys.create_order_done,
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
