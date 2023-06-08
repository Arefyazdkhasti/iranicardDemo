import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iranicard_demo/data/repository/banner_repository.dart';
import 'package:iranicard_demo/data/repository/item_repository.dart';
import 'package:iranicard_demo/ui/dashboard/bloc/dashboard_bloc.dart';
import 'package:iranicard_demo/ui/seach/SearchScreen.dart';

import '../../common/utils.dart';
import '../../data/model/ItemEntity.dart';
import '../../data/repository/auth_repository.dart';
import '../../widgets/ImageLoadingService.dart';
import '../../widgets/slider.dart';
import '../../widgets/toolbar.dart';
import '../LightThemeColor.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return BlocProvider(
      create: (context) {
        final bloc = DashboardBloc(
            bannerRepository: bannerRepository, itemRepository: itemRepository);

        bloc.add(DashboardStarted());
        return bloc;
      },
      child: Scaffold(body:
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
        if (state is DashboardSucces) {
          return ListView.builder(
              physics: defaultScrollPhysics,
              itemCount: 6,
              itemBuilder: (contect, index) {
                switch (index) {
                  case 0:
                    return const ToolBar();
                  case 1:
                    return BannerSlider(banners: state.banners);
                  case 2:
                    return const _Services();
                  case 3:
                    List<ItemEntity> itemsMostPopular = state.onlineShoppings;
                    return _HorizonatalItemList(
                      themeData: themeData,
                      title: "کارت های پرفروش",
                      list: itemsMostPopular,
                      isSpecial: true,
                    );
                  case 4:
                    List<ItemEntity> itemsGameGiftCards = state.gameGiftCards;
                    return _HorizonatalItemList(
                      themeData: themeData,
                      title: "گیفت کارت های بازی",
                      list: itemsGameGiftCards,
                      isSpecial: false,
                    );
                  case 6:
                    return const SizedBox(height: 24);
                  default:
                    return Container();
                }
              });
        } else if (state is DashboardLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DashboardError) {
          return Center(
              child: Text(state.exeption.message,
                  style: themeData.textTheme.bodyMedium));
        } else {
          throw Exception("State Not Supported!");
        }
      })),
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
        height: 150,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset('assets/svg/dashboardincome.svg',
                        semanticsLabel: 'Acme Logo'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: SvgPicture.asset('assets/svg/dashboardshopping.svg',
                        semanticsLabel: 'Acme Logo'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset('assets/svg/dashboardsites.svg',
                        semanticsLabel: 'Acme Logo'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: SvgPicture.asset('assets/svg/dashboardcrypto.svg',
                        semanticsLabel: 'Acme Logo'),
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

class _HorizonatalItemList extends StatefulWidget {
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
  State<_HorizonatalItemList> createState() => _HorizonatalItemListState();
}

class _HorizonatalItemListState extends State<_HorizonatalItemList> {
  String accessTocken = '';

  @override
  void initState() {
    super.initState();
    authRepository.loadAuthInfo().then((result) {
      setState(() {
        accessTocken = result;
      });
    });
  }

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
                  Text(widget.title,
                      style: widget.themeData.textTheme.titleMedium),
                  const SizedBox(width: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: LightThemeColor.itemBackgroundColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: widget.isSpecial
                          ? Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("ویژه",
                                  style: widget.themeData.textTheme.bodyMedium
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
                itemCount: widget.list.length,
                physics: defaultScrollPhysics,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 220,
                          height: 150,
                          child: ImageLoadingService(
                              imageUrl: widget.list[index].imageUrl,
                              borderRadius: BorderRadius.circular(8),
                              accessTocken: accessTocken,),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 8,
                          bottom: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.list[index].title,
                                maxLines: 1,
                                style: widget.themeData.textTheme.labelMedium
                                    ?.copyWith(
                                        color: Colors.white, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                widget.list[index].subtitle,
                                maxLines: 1,
                                style: widget.themeData.textTheme.labelMedium
                                    ?.copyWith(
                                        color:
                                            LightThemeColor.secondaryTextColor,
                                        fontSize: 14),
                              ),
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