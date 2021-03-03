import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/create_order_provider.dart';
import 'package:logos_new/providers/geo_provider.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class CreateOrderLocationScreen extends StatefulWidget {
  final bool isOrigin;

  const CreateOrderLocationScreen({
    @required this.isOrigin,
  });

  @override
  _CreateOrderLocationScreenState createState() =>
      _CreateOrderLocationScreenState();
}

class _CreateOrderLocationScreenState extends State<CreateOrderLocationScreen> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController(
        text: widget.isOrigin
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .originAddress
            : Provider.of<CreateOrderProvider>(context, listen: false)
                .destinationAddress);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _autocompleteList =
        Provider.of<GeoProvider>(context).autocompleteList;
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
              Provider.of<GeoProvider>(context, listen: false).clearData();
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.isOrigin
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                LocaleKeys.create_order_address,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  fontSize: 14,
                ),
              ).tr(),
            ),
            Container(
              height: 46,
              child: TextFormField(
                onChanged: (value) async {
                  final valueBefore = _controller.text;
                  await Future.delayed(Duration(milliseconds: 500), () async {
                    final valueAfter = _controller.text;
                    if (valueBefore == valueAfter) {
                      if (_controller.text.length >= 3) {
                        try {
                          await Provider.of<GeoProvider>(context, listen: false)
                              .getAutocompleteList(
                                  context: context, location: _controller.text);
                        } catch (error) {
                          print(error);
                        }
                      } else {
                        Provider.of<GeoProvider>(context, listen: false)
                            .clearAutocompleteList();
                      }
                    }
                  });
                },
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.name,
                controller: _controller,
                style: TextStyle(
                  color: Style.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                cursorColor: Style.primaryColor,
                decoration: InputDecoration(
                  isDense: true,
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(0, 0, 0, 0.05)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.place_outlined,
                    size: 20,
                    color: Style.primaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    LocaleKeys.create_order_choose_on_map,
                    style: TextStyle(
                      color: Style.primaryColor,
                      fontSize: 14,
                    ),
                  ).tr()
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () {
                    if (widget.isOrigin) {
                      Provider.of<CreateOrderProvider>(context, listen: false)
                          .setLatFrom(double.parse(
                              _autocompleteList[i]['marker']['latitude']));
                      Provider.of<CreateOrderProvider>(context, listen: false)
                          .setLonFrom(double.parse(
                              _autocompleteList[i]['marker']['longitude']));
                      Provider.of<CreateOrderProvider>(context, listen: false)
                          .setOriginAddress(
                              _autocompleteList[i]['display_name']);
                      Provider.of<GeoProvider>(context, listen: false)
                          .clearData();
                      Navigator.pop(context);
                    } else {
                      Provider.of<CreateOrderProvider>(context, listen: false)
                          .setLatTo(double.parse(
                              _autocompleteList[i]['marker']['latitude']));
                      Provider.of<CreateOrderProvider>(context, listen: false)
                          .setLonTo(double.parse(
                              _autocompleteList[i]['marker']['longitude']));
                      Provider.of<CreateOrderProvider>(context, listen: false)
                          .setDestinationAddress(
                              _autocompleteList[i]['display_name']);
                      Provider.of<GeoProvider>(context, listen: false)
                          .clearData();
                      Navigator.pop(context);
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      _autocompleteList[i]['display_name'],
                      style: TextStyle(
                          fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                  ),
                ),
                itemCount: _autocompleteList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
