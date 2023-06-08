import 'package:flutter/material.dart';

import '../ui/LightThemeColor.dart';
import '../ui/seach/SearchScreen.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(children: [
        Expanded(
            child: Container(
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: LightThemeColor.itemBackgroundColor),
          child: InkWell(
            onTap: () => {
              Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (context) => const SearchScreen()))
            },
            child: Row(children: [
              const SizedBox(
                width: 4,
              ),
              const Icon(Icons.search, color: LightThemeColor.iconColos),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  'جست و جو در ایرانیکارت',
                  style: themeData.textTheme.bodyMedium
                      ?.copyWith(color: LightThemeColor.primaryTextColor),
                ),
              ),
            ]),
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: LightThemeColor.itemBackgroundColor),
            child: const Icon(Icons.battery_charging_full,
                color: LightThemeColor.iconColos),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: LightThemeColor.itemBackgroundColor),
            child: const Icon(Icons.wallet, color: LightThemeColor.iconColos),
          ),
        ),
      ]),
    );
  }
}
