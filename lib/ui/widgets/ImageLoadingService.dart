import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadingService extends StatelessWidget {
  const ImageLoadingService({super.key, required this.imageUrl, this.borderRadius});

  final String imageUrl;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Container(color: Colors.red)),
    );
  }
}
