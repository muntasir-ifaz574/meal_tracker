import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    required this.path,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  }) : super(key: key);

  final String? path;
  final BoxFit fit;
  final double? height, width;
  final Color? color;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    final imagePath = path == null || path == '' ? KImages.defaultImage : path;

    if (isFile) {
      return Image.file(
        File(imagePath!),
        fit: fit,
        color: color,
        height: height,
        width: width,
      );
    }

    if (imagePath!.endsWith('.svg')) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          imagePath,
          fit: fit,
          height: height,
          width: width,
          color: color,
        ),
      );
    }
    if (imagePath.startsWith('http') ||
        imagePath.startsWith('https') ||
        imagePath.startsWith('www.')) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        fit: fit,
        color: color,
        height: height,
        width: width,
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: kThemeColor,
                strokeWidth: 2,
              ),
            ),
            // child: Shimmer.fromColors(
            //   baseColor: Colors.grey[300]!,
            //   highlightColor: Colors.grey[100]!,
            //   child: Container(
            //     height: height,
            //     width: width,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(16),
            //     ),
            //   ),
            // ),
          );
        },
        errorWidget: (context, url, error) => const Image(image: AssetImage(KImages.defaultImage)),
      );
    }
    return Image.asset(
      imagePath,
      fit: fit,
      color: color,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Image(
          image: const AssetImage(KImages.defaultImage),
          height: height,
          width: width,
        );
      },
    );
  }
}
