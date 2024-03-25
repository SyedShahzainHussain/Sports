import 'package:flutter/material.dart';
import 'package:sports/common/widget/container/circular_container.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';

import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';

class ChooseCategory extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onTap1;
  final String title;
  final String image;
  final String title1;
  final String image1;
  const ChooseCategory({
    super.key,
    required this.onTap,
    required this.onTap1,
    required this.image,
    required this.image1,
    required this.title,
    required this.title1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(STexts.selectedCategory),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSized.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CircularContainer(
                    title: title,
                    imageUrl: image,
                    onTap: onTap,
                  ),
                ),
                const SizedBox(
                  width: TSized.spacebetweenItem,
                ),
                Expanded(
                  child: CircularContainer(
                    title: title1,
                    imageUrl: image1,
                    onTap: onTap1,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
