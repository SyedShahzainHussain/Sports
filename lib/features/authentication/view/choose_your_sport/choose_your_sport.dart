import 'package:flutter/material.dart';
import 'package:sports/common/widget/container/circular_container.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';

import 'package:sports/utils/constants/image_strings.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';

class ChooseYourSports extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onTap1;
  const ChooseYourSports({super.key,required this.onTap,required this.onTap1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(STexts.chooseYourSports),
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
                    title: STexts.cricket,
                    imageUrl: TImageString.cricketImage,
                    onTap: onTap,
                  ),
                ),
                const SizedBox(
                  width: TSized.spacebetweenItem,
                ),
                Expanded(
                  child: CircularContainer(
                    title: STexts.swimming,
                    imageUrl: TImageString.swimmingImage,
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
