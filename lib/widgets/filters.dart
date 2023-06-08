import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/LightThemeColor.dart';

class Fliters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(12.0),
      child:  Row(
        children: [
          const _FilterItem(
            icon: Icon(Icons.done),
          ),
          const SizedBox(
            width: 12,
          ),
          const _FilterItem(
            icon: Icon(CupertinoIcons.globe),
          ),
        ],
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  final Icon icon;

  const _FilterItem({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: LightThemeColor.itemBackgroundColor,
          borderRadius: BorderRadius.circular(4)),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            const SizedBox(
              width: 8,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'test',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(Icons.arrow_drop_down_sharp)
          ]),
    );
  }
}
