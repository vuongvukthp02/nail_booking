import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usastarnail/providers/Bookings.dart';
import 'package:usastarnail/providers/profile.dart';
import 'package:usastarnail/providers/Services.dart';
import 'package:usastarnail/providers/auth.dart';
import 'package:usastarnail/screens/RFEmailSignInScreen.dart';

import 'package:usastarnail/screens/RFHomeScreen.dart';
import 'package:usastarnail/screens/RFSignUpScreen.dart';
import 'package:usastarnail/screens/RFSplashScreen.dart';
import 'package:usastarnail/store/AppStore.dart';
import 'package:usastarnail/utils/AppTheme.dart';
import 'package:usastarnail/utils/RFConstant.dart';
import 'package:provider/provider.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) =>  Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, proFile>(
          create: (_) => proFile(uid: 0, authToken: ''),
          update: (_, auth, previousSanPhams) {
            return proFile(
              uid: auth.userId.toInt(),
              authToken: auth.token,
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, Bookings>(
          create: (_) => Bookings(uid: 0, authToken: ''),
          update: (_, auth, previousSanPhams) {
            return Bookings(
              uid: auth.userId.toInt(),
              authToken: auth.token,
            );
          },
          // create: ,
        ),
        ChangeNotifierProxyProvider<Auth, Services>(
          create: (_) => Services(uid: 0, authToken: ''),
          update: (_, auth, previousSanPhams) {
            return Services(
              uid: auth.userId.toInt(),
              authToken: auth.token,
            );
          },
          // create: ,
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          scrollBehavior: SBehavior(),
          navigatorKey: navigatorKey,
          title: 'BOOKING USASTARNAILS',
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          themeMode: appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: auth.isAuth ? RFHomeScreen() :  RFSplashScreen(),
          routes: {
            RFHomeScreen.routeName: (ctx) => RFHomeScreen(),
            RFEmailSignInScreen.routeName: (ctx) => RFEmailSignInScreen(),
            RFSignUpScreen.routeName: (ctx) => RFSignUpScreen(),
          },
        ),
      ),
    );
  }
}
