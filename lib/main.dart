import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logos_new/providers/agreements_provider.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/providers/create_order_provider.dart';
import 'package:logos_new/providers/detail_order_provider.dart';
import 'package:logos_new/providers/geo_provider.dart';
import 'package:logos_new/providers/logged_state_provider.dart';
import 'package:logos_new/providers/orders_search_provider.dart';
import 'package:logos_new/providers/references_provider.dart';
import 'package:logos_new/providers/sender_orders_provider.dart';
import 'package:logos_new/providers/transporter_orders_provider.dart';
import 'package:logos_new/screens/create_order_screen.dart';
import 'package:logos_new/screens/orders_search_screen.dart';
import 'package:logos_new/screens/my_orders_screen.dart';
import './screens/welcome_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ru', 'RU'),
          Locale('uk', 'UA')
        ],
        path: 'assets/translations', // <-- change patch to your
        fallbackLocale: Locale('ru', 'RU'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<void> _future(BuildContext context) async {
      await Provider.of<UserProvider>(context, listen: false)
          .getUser(context: context);
      await Provider.of<ReferencesProvider>(context, listen: false)
          .getReferences(context);

      if (Provider.of<UserProvider>(context, listen: false).user['roles'][0] ==
          'transporter') {
        await Provider.of<OrdersSearchProvider>(context, listen: false)
            .getOpenedOrders(context: context);
      }
      print('this one');
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (ctx) => AuthProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => LoggedStateProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => AgreementProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => ReferencesProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => UserProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => OrdersSearchProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => CreateOrderProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => SenderOrdersProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => TransporterOrdersProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => GeoProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => DetailOrderProvider(),
            ),
          ],
          child: Builder(
            builder: (context) => MaterialApp(
              localizationsDelegates: [
                // ... app-specific localization delegate[s] here
                // TODO: uncomment the line below after codegen
                // AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en', 'US'),
                Locale('ru', 'RU'),
                Locale('uk', 'UA')
              ],
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.amber,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                fontFamily: 'Roboto',
              ),
              home: Provider.of<LoggedStateProvider>(context).isAuth
                  ? FutureBuilder(
                      future: _future(context),
                      builder: (ctx, dataResultSnapshot) =>
                          dataResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : Provider.of<UserProvider>(context).user['roles']
                                          [0] ==
                                      'sender'
                                  ? CreateOrderScreen()
                                  : OrdersSearchScreen())
                  : FutureBuilder(
                      future: Provider.of<LoggedStateProvider>(context,
                              listen: false)
                          .tryAutoLogin(),
                      builder: (ctx, dataResultSnapshot) =>
                          dataResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : WelcomeScreen(),
                    ),
              routes: {},
            ),
          )),
    );
  }
}
