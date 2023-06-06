
import 'package:flutter/material.dart';

import '../../common/utils.dart';
import '../../data/model/BannerEntity.dart';
import '../../data/model/ItemEntity.dart';
import '../LightThemeColor.dart';
import '../widgets/ImageLoadingService.dart';
import '../widgets/slider.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (contect, index) {
            switch (index) {
              case 0:
                return const ToolBar();
              case 1:
                List<BannerEntity> banners = [
                  BannerEntity(
                      id: 0,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300"),
                  BannerEntity(
                      id: 1,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300"),
                  BannerEntity(
                      id: 2,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300")
                ];
                return BannerSlider(banners: banners);
              case 2:
                return _Services();
              case 3:
                List<ItemEntity> itemsMostPopular = [
                  ItemEntity(
                      id: 0,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300",
                      title: "گیفت کارت امازون",
                      subtitle: "وبسایت"),
                  ItemEntity(
                      id: 2,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300",
                      title: "گیفت کارت امازون",
                      subtitle: "وبسایت"),
                  ItemEntity(
                      id: 3,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300",
                      title: "گیفت کارت امازون",
                      subtitle: "وبسایت"),
                ];
                return _HorizonatalItemList(
                  themeData: themeData,
                  title: "کارت های پرفروش",
                  list: itemsMostPopular,
                  isSpecial: true,
                );
              case 4:
                List<ItemEntity> itemsGameGiftCards = [
                  ItemEntity(
                      id: 0,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300",
                      title: "گیفت کارت امازون",
                      subtitle: "وبسایت"),
                  ItemEntity(
                      id: 2,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300",
                      title: "گیفت کارت امازون",
                      subtitle: "وبسایت"),
                  ItemEntity(
                      id: 3,
                      imageUrl: "https://picsum.photos/seed/picsum/200/300",
                      title: "گیفت کارت امازون",
                      subtitle: "وبسایت"),
                ];
                return _HorizonatalItemList(
                  themeData: themeData,
                  title: "گیفت کارت های بازی",
                  list: itemsGameGiftCards,
                  isSpecial: false,
                );
              default:
                return Container();
            }
          }),
    );
  }
}

class _Services extends StatelessWidget {
  const _Services({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 200,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      height: 75,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green,
                      height: 75,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      height: 75,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      height: 75,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HorizonatalItemList extends StatelessWidget {
  const _HorizonatalItemList(
      {super.key,
      required this.themeData,
      required this.title,
      required this.list,
      required this.isSpecial});

  final ThemeData themeData;
  final String title;
  final List<ItemEntity> list;
  final bool isSpecial;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(title, style: themeData.textTheme.titleMedium),
                  const SizedBox(width: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: LightThemeColor.itemBackgroundColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: isSpecial
                          ? Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("ویژه",
                                  style: themeData.textTheme.bodyMedium
                                      ?.copyWith(
                                          color: LightThemeColor.primaryColor)),
                            )
                          : Container()),
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.arrow_forward,
                    color: LightThemeColor.iconColos,
                  ))
            ],
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                itemCount: list.length,
                physics: dfaultScrollPhysics,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Stack(
                      children: [
                        Container(
                          width: 220,
                          height: 150,
                          child: ImageLoadingService(
                              imageUrl: list[index].imageUrl,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 200,
                            height: 55,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                                color: Colors.amber),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 8,
                          bottom: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list[index].title),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(list[index].subtitle),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

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
          child: Row(children: [
            const SizedBox(
              width: 4,
            ),
            const Icon(Icons.search, color: LightThemeColor.iconColos),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'جست و جو در ایرانیکارت',
                  hintStyle: themeData.textTheme.bodyMedium
                      ?.copyWith(color: LightThemeColor.primaryTextColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ]),
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
