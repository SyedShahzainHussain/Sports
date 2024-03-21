import 'package:flutter/material.dart';
import 'package:sports/common/widget/container/circular_container.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/features/authentication/view/choose_your_category/choose_your_category.dart';
import 'package:sports/features/authentication/view/modules/player/views/cricket_player/cricket_player.dart';
import 'package:sports/features/authentication/view/modules/player/views/swimming_player/swimming_player.dart';

import 'package:sports/utils/constants/image_strings.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';
import 'package:sports/utils/helper/helper_function.dart';

class ChooseYourSports extends StatelessWidget {
  const ChooseYourSports({super.key});

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
                    onTap: () {
                      THelperFunction.navigatedToScreen(
                          context,
                          ChooseCategory(
                            title: STexts.cricketPlayer,
                            title1: STexts.cricketOrganization,
                            image: TImageString.player,
                            image1: TImageString.organization,
                            onTap: () {
                              THelperFunction.navigatedToScreen(
                                  context, const CricketPlayer());
                            },
                            onTap1: () {
                              THelperFunction.showFlushBar(
                                  "Cricket Organization Progress", context);
                            },
                          ));
                    },
                  ),
                ),
                const SizedBox(
                  width: TSized.spacebetweenItem,
                ),
                Expanded(
                  child: CircularContainer(
                    title: STexts.swimming,
                    imageUrl: TImageString.swimmingImage,
                    onTap: () {
                      THelperFunction.navigatedToScreen(
                          context,
                          ChooseCategory(
                            title: STexts.swimmingPlayer,
                            title1: STexts.swimmingOrganization,
                            image: TImageString.swimmingPlayerImage,
                            image1: TImageString.organization,
                            onTap: () {
                              THelperFunction.navigatedToScreen(
                                  context, const SwimmingPlayerScreen());
                            },
                            onTap1: () {
                              THelperFunction.showFlushBar(
                                  "Swimming Organization Progress", context);
                            },
                          ));
                    },
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
