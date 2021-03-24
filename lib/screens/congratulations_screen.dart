import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logos_new/providers/agreements_provider.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/providers/logged_state_provider.dart';
import 'package:logos_new/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../generated/locale_keys.g.dart';
import './register_phone_number_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import '../style.dart';

class CongratulationsScreen extends StatelessWidget {
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/illustrations/choose-role.svg',
                  width: 137,
                  height: 137,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              LocaleKeys.create_account_congrats_title,
              style: TextStyle(
                color: Style.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ).tr(),
            SizedBox(
              height: 20,
            ),
            Text(
              LocaleKeys.create_account_congrats_message,
              style: TextStyle(
                color: Style.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
            Expanded(
              child: Container(),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                disabledColor: Color(0xffECECEC),
                elevation: 0,
                onPressed: () {
                  Provider.of<LoggedStateProvider>(context, listen: false)
                      .setIsAuth(true);
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Style.secondaryColor,
                child: Text(
                  LocaleKeys.create_account_begin,
                  style: TextStyle(
                      color: Style.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ).tr(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
