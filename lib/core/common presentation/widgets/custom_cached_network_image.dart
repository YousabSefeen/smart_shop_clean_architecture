import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const CustomCachedNetworkImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.fill,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      errorWidget: (context, s, _) =>
          Image.asset('assets/images/imageError.png'),
      placeholder: (context, _) => Image.asset('assets/images/loading.gif'),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
