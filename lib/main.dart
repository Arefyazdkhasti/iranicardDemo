import 'package:flutter/material.dart';
import 'package:iranicard_demo/data/model/AuthInfo.dart';
import 'package:iranicard_demo/data/repository/auth_repository.dart';
import 'package:iranicard_demo/ui/LightThemeColor.dart';
import 'package:iranicard_demo/ui/auth/LoginScreen.dart';
import 'package:iranicard_demo/ui/root/RootScreen.dart';

void main() {
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
      home: ValueListenableBuilder<AuthInfoEntity?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, value, child) {
          bool isAuthenticated = value?.accessTocken != null;
          return Directionality(
              textDirection: TextDirection.rtl, child: isAuthenticated ? RootScreen() : const LoginScreen());
        },
      ),
    );
  }
}
