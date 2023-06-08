import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iranicard_demo/data/repository/auth_repository.dart';
import 'package:iranicard_demo/ui/LightThemeColor.dart';
import 'package:iranicard_demo/ui/auth/LoginScreen.dart';
import 'package:iranicard_demo/ui/root/RootScreen.dart';

import 'common/search_response_adapter.dart';
import 'data/model/AuthInfo.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SearchResponseAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
        color: LightThemeColor.primaryTextColor,
        fontFamily: 'Lotus',
        fontSize: 18);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            bodyMedium: defaultTextStyle,
            bodySmall: defaultTextStyle.apply(
                color: LightThemeColor.secondaryTextColor),
            titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
            titleMedium: defaultTextStyle,
            labelMedium: defaultTextStyle),
        colorScheme: const ColorScheme.light(
            primary: LightThemeColor.primaryColor,
            secondary: LightThemeColor.secondaryColor,
            onSecondary: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      //listen to the valueNotifier in auth repository and decide where to go in the moment of launch
      home: ValueListenableBuilder<AuthInfoEntity?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, value, child) {
          bool isAuthenticated = value?.accessTocken != null;
          return Directionality(
              textDirection: TextDirection.rtl,
              child: isAuthenticated ? RootScreen() : const LoginScreen());
        },
      ),
    );
  }
}
