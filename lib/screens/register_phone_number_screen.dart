import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logos_new/generated/locale_keys.g.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/screens/verify_phone_number_screen.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class RegisterPhoneNumberScreen extends StatefulWidget {
  @override
  _RegisterPhoneNumberScreenState createState() =>
      _RegisterPhoneNumberScreenState();
}

class _RegisterPhoneNumberScreenState extends State<RegisterPhoneNumberScreen> {
  TextEditingController _phoneController;
  String _phoneNumber;

  @override
  void initState() {
    _phoneController = TextEditingController();
    _phoneNumber = _phoneController.text;
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = Provider.of<AuthProvider>(context).isLoading;
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
            if (Provider.of<AuthProvider>(context, listen: false).phoneNumber !=
                null) {
              Provider.of<AuthProvider>(context, listen: false)
                  .setPhoneNumber(null);
            }
            Provider.of<AuthProvider>(context, listen: false).clearErrors();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.create_account_step1,
          style: TextStyle(
            color: Style.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ),
      body: Container(
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
                  LocaleKeys.create_account_phone_number_title,
                  style: TextStyle(
                    color: Style.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  LocaleKeys.create_account_phone_number_prompt,
                  style: TextStyle(
                    color: Style.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ).tr(),
                SizedBox(
                  height: 7,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = value;
                    });
                  },
                  controller: _phoneController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Style.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  cursorColor: Style.primaryColor,
                  decoration: InputDecoration(
                    errorText: Provider.of<AuthProvider>(context)
                                .errors['number'] !=
                            null
                        ? Provider.of<AuthProvider>(context).errors['number'][0]
                        : null,
                    counterText: '',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                    ),
                    isDense: true,
                    fillColor: Color(0xffF9F9F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    isCollapsed: true,
                    prefix: Container(
                      height: 50,
                      width: 60,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
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
                SizedBox(
                  height: 8,
                ),
                Text(
                  LocaleKeys.create_account_phone_number_message,
                  style: TextStyle(
                    color: Style.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ).tr(),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    disabledColor: Color(0xffECECEC),
                    elevation: 0,
                    onPressed: _phoneNumber.length < 10
                        ? null
                        : () async {
                            Provider.of<AuthProvider>(context, listen: false)
                                .setPhoneNumber(_phoneNumber);
                            try {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setLoading(true);
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .registerPhoneNumber(
                                context: context,
                              );
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setLoading(false);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VerifyPhoneNumberScreen(),
                                ),
                              );
                            } catch (error) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .setLoading(false);
                            }
                          },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Style.secondaryColor,
                    child: _isLoading
                        ? SpinKitThreeBounce(
                            color: Style.primaryColor,
                            size: 25.0,
                          )
                        : Text(
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
    );
  }
}
