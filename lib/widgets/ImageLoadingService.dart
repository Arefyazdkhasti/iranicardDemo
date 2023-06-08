import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadingService extends StatelessWidget {
  const ImageLoadingService(
      {super.key,
      required this.imageUrl,
      this.borderRadius,
      required this.accessTocken});

  final String imageUrl;
  final BorderRadius? borderRadius;
  final String accessTocken;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
          imageUrl: imageUrl,
          httpHeaders: {"Authorization": "Bearer $accessTocken"},
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Image.asset('assets/images/logo.png')),
    );
  }
}
