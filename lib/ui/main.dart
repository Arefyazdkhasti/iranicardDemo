import 'package:flutter/material.dart';
import 'package:iranicard_demo/ui/root/RootScreen.dart';
import 'lightThemeColor.dart';


void main() {
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
          bodySmall:
              defaultTextStyle.apply(color: LightThemeColor.secondaryTextColor),
          titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
          titleMedium: defaultTextStyle
        ),
        colorScheme: const ColorScheme.light(
            primary: LightThemeColor.primaryColor,
            secondary: LightThemeColor.secondaryColor,
            onSecondary: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: Directionality(
          textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
