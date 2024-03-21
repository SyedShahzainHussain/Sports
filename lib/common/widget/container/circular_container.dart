import 'package:flutter/material.dart';
import 'package:sports/utils/constants/colors.dart';
import 'package:sports/utils/constants/size.dart';

class CircularContainer extends StatelessWidget {
  final String title;
  final bool isNetworkImage;
  final bool showBorderRadius;
  final String imageUrl;
  final double borderRadius;
  final Color color;
  final void Function()? onTap;
  const CircularContainer({
    super.key,
    required this.title,
    required this.imageUrl,
    this.isNetworkImage = false,
    this.showBorderRadius = true,
    this.borderRadius = TSized.cardRadiusMd,
    this.color = TColors.accent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(TSized.defaultSpace),
        decoration: BoxDecoration(
          color: color,
          borderRadius: showBorderRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
        ),
        child: Column(
          children: [
            Image(
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider,
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
