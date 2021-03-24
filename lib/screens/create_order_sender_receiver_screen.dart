import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/create_order_provider.dart';
import 'package:logos_new/widgets/appbar_leading.dart';
import 'package:provider/provider.dart';
import 'package:libphonenumber/libphonenumber.dart';

import '../style.dart';

class CreateOrderSenderReceiverScreen extends StatefulWidget {
  final bool isSender;

  const CreateOrderSenderReceiverScreen({
    @required this.isSender,
  });

  @override
  _CreateOrderSenderReceiverScreenState createState() =>
      _CreateOrderSenderReceiverScreenState();
}

class _CreateOrderSenderReceiverScreenState
    extends State<CreateOrderSenderReceiverScreen> {
  TextEditingController _nameController;
  TextEditingController _surnameController;
  TextEditingController _phoneController;
  String _name;
  String _surname;
  String _phone;
  bool _useCredentials;

  @override
  void initState() {
    _useCredentials = widget.isSender
        ? Provider.of<CreateOrderProvider>(context, listen: false)
                    .useSenderCredentials !=
                null
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .useSenderCredentials
            : false
        : Provider.of<CreateOrderProvider>(context, listen: false)
                    .useReceiverCredentials !=
                null
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .useReceiverCredentials
            : false;
    _nameController = TextEditingController(
        text: widget.isSender
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .senderName
            : Provider.of<CreateOrderProvider>(context, listen: false)
                .receiverName);
    _name = _nameController.text;
    _surnameController = TextEditingController(
        text: widget.isSender
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .senderSurname
            : Provider.of<CreateOrderProvider>(context, listen: false)
                .receiverSurname);
    _surname = _surnameController.text;
    _phoneController = TextEditingController(
        text: widget.isSender
            ? Provider.of<CreateOrderProvider>(context, listen: false)
                .senderPhone
            : Provider.of<CreateOrderProvider>(context, listen: false)
                .receiverPhone);
    _phone = _phoneController.text;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
          widget.isSender
              ? LocaleKeys.create_order_sender
              : LocaleKeys.create_order_receiver,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          height: height - kToolbarHeight - 20,
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (_useCredentials) {
                    setState(() {
                      _useCredentials = false;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.create_order_me,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _useCredentials
                                ? Style.greyColor
                                : Style.primaryColor),
                      ).tr(),
                      Icon(
                        Icons.check,
                        size: 24,
                        color: _useCredentials
                            ? Color(0xffFAFAFA)
                            : Style.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                height: 1,
                thickness: 1,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (!_useCredentials) {
                    setState(() {
                      _useCredentials = true;
                    });
                  }
                  // if (widget.isSender) {
                  //   if (!Provider.of<CreateOrderProvider>(context,
                  //           listen: false)
                  //       .useSenderCredentials) {
                  //     Provider.of<CreateOrderProvider>(context, listen: false)
                  //         .setUseSenderCredentials(true);
                  //   }
                  // } else {
                  //   if (!Provider.of<CreateOrderProvider>(context,
                  //           listen: false)
                  //       .useReceiverCredentials) {
                  //     Provider.of<CreateOrderProvider>(context, listen: false)
                  //         .setUseReceiverCredentials(true);
                  //   }
                  // }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.create_order_somebody_else,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _useCredentials
                                ? Style.primaryColor
                                : Style.greyColor),
                      ).tr(),
                      Icon(
                        Icons.check,
                        size: 24,
                        color: _useCredentials
                            ? Style.primaryColor
                            : Color(0xffFAFAFA),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                height: 1,
                thickness: 1,
              ),
              _useCredentials
                  ? Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              LocaleKeys.create_order_first_name,
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ).tr(),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: 50,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              cursorColor: Style.primaryColor,
                              decoration: InputDecoration(
                                counterText: '',
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Style.primaryColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              LocaleKeys.create_order_last_name,
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ).tr(),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: 50,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _surname = value;
                                });
                              },
                              keyboardType: TextInputType.name,
                              controller: _surnameController,
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              cursorColor: Style.primaryColor,
                              decoration: InputDecoration(
                                isDense: true,
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Style.primaryColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              LocaleKeys.create_order_phone,
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ).tr(),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: 50,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _phone = value;
                                });
                              },
                              controller: _phoneController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              cursorColor: Style.primaryColor,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Style.primaryColor),
                                ),
                                counterText: '',
                                isDense: true,
                                prefix: Container(
                                  height: 50,
                                  width: 60,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  margin: EdgeInsets.only(
                                    right: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Color(0xffECECEC),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '+38',
                                    style: TextStyle(
                                      color: Style.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
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
                  onPressed: _useCredentials &&
                          (_name.length < 1 ||
                              _surname.length < 1 ||
                              _phone.length < 1)
                      ? null
                      : () async {
                          try {
                            if (_useCredentials) {
                              String phoneNumber = '+38' + _phone;
                              bool isPhoneValid =
                                  await PhoneNumberUtil.isValidPhoneNumber(
                                      phoneNumber: phoneNumber, isoCode: 'UA');
                              print(phoneNumber);
                              print(isPhoneValid);
                              if (!isPhoneValid) {
                                return;
                              }
                            }
                            if (widget.isSender) {
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setSenderName(_name);
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setSenderSurname(_surname);
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setSenderPhone(_phone);
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setUseSenderCredentials(_useCredentials);
                            } else {
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setReceiverName(_name);
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setReceiverSurname(_surname);
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setReceiverPhone(_phone);
                              Provider.of<CreateOrderProvider>(context,
                                      listen: false)
                                  .setUseReceiverCredentials(_useCredentials);
                            }
                            Navigator.pop(context);
                          } catch (error) {
                            print(error);
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  LocaleKeys.errors_general,
                                ).tr(),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
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
      ),
    );
  }
}
