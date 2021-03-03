import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logos_new/screens/choose_role_screen.dart';
import 'package:logos_new/screens/sign_in_screen.dart';
import '../generated/locale_keys.g.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
          ),
          ClipPath(
            child: Container(
              width: width,
              height: height * 0.52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffFFF500), Color(0xffFFC200)],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  SvgPicture.asset(
                    'assets/images/icons/main-icon.svg',
                    width: 108,
                    height: 108,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Logos',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff242A38),
                    ),
                  ),
                ],
              ),
            ),
            clipper: CustomClipPath(),
          ),
          Positioned.fill(
            child: Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.5,
                  ),
                  Text(
                    LocaleKeys.welcome_title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff242A38),
                    ),
                  ).tr(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    LocaleKeys.welcome_description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff242A38),
                    ),
                  ).tr(),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    width: width,
                    height: 50,
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseRoleScreen(),
                            ),
                          );
                        },
                        color: Color(0xff242A38),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          LocaleKeys.welcome_create_account,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ).tr()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: width,
                    height: 50,
                    child: OutlineButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        borderSide: BorderSide(
                          color: Color(0xff242A38),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          LocaleKeys.welcome_sign_in,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff242A38),
                          ),
                        ).tr()),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 130);
    path.quadraticBezierTo(
        size.width / 9, size.height - 30, size.width / 2, size.height - 55);
    path.quadraticBezierTo(
        8 / 9 * size.width, size.height - 75, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
