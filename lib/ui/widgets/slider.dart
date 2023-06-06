import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/utils.dart';
import '../../data/model/BannerEntity.dart';
import '../LightThemeColor.dart';
import 'ImageLoadingService.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerEntity> banners;
  final PageController _pageController = PageController();

  BannerSlider({super.key, required this.banners});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      // width of the slider always be twice as its height -> better experience in tablet
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
              controller: _pageController,
              itemCount: banners.length,
              physics: dfaultScrollPhysics,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: ImageLoadingService(
                      imageUrl: banners[index].imageUrl,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )),
          Positioned(
              left: 0,
              bottom: 8,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: banners.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                    spacing: 4.0,
                    dotWidth: 8.0,
                    dotHeight: 8.0,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: LightThemeColor.primaryColor,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
