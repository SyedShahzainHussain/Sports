import 'package:flutter/material.dart';
import 'package:sports/common/widget/container/circular_container.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/common/widget/choose_your_category/choose_your_category.dart';
import 'package:sports/common/widget/choose_your_sport/choose_your_sport.dart';
import 'package:sports/features/authentication/view/modules/organization/views/cricket_organization/cricket_login_organization.dart';
import 'package:sports/features/authentication/view/modules/organization/views/cricket_organization/cricket_register_organization.dart';
import 'package:sports/features/authentication/view/modules/organization/views/swimming_organization/swimming_login_organization.dart';
import 'package:sports/features/authentication/view/modules/organization/views/swimming_organization/swimming_register_organization.dart';
import 'package:sports/features/authentication/view/modules/player/views/cricket_player/cricket_login_player.dart';
import 'package:sports/features/authentication/view/modules/player/views/cricket_player/cricket_register_player.dart';
import 'package:sports/features/authentication/view/modules/player/views/swimming_player/swimming_player_login_form.dart';
import 'package:sports/features/authentication/view/modules/player/views/swimming_player/swimming_register_player.dart';
import 'package:sports/utils/constants/image_strings.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';
import 'package:sports/utils/helper/helper_function.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(STexts.loginAndRegister),
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
                    title: STexts.register,
                    imageUrl: TImageString.registerImage,
                    onTap: () {
                      THelperFunction.navigatedToScreen(
                          context,
                          ChooseYourSports(
                            onTap: () {
                              THelperFunction.navigatedToScreen(
                                  context,
                                  ChooseCategory(
                                    title: STexts.cricketPlayer,
                                    title1: STexts.cricketOrganization,
                                    image: TImageString.player,
                                    image1: TImageString.organization,
                                    onTap: () {
                                      THelperFunction.navigatedToScreen(context,
                                          const CricketRegisterPlayer());
                                    },
                                    onTap1: () {
                                      THelperFunction.navigatedToScreen(context,
                                          const CricketRegisterOrganization());
                                    },
                                  ));
                            },
                            onTap1: () {
                              THelperFunction.navigatedToScreen(
                                  context,
                                  ChooseCategory(
                                    title: STexts.swimmingPlayer,
                                    title1: STexts.swimmingOrganization,
                                    image: TImageString.swimmingPlayerImage,
                                    image1: TImageString.organization,
                                    onTap: () {
                                      THelperFunction.navigatedToScreen(context,
                                          const SwimmingRegisterPlayerScreen());
                                    },
                                    onTap1: () {
                                      THelperFunction.navigatedToScreen(context,
                                          const SwimmingRegisterOrganization());
                                    },
                                  ));
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
                    title: STexts.login,
                    imageUrl: TImageString.loginImage,
                    onTap: () {
                      THelperFunction.navigatedToScreen(
                          context,
                          ChooseYourSports(
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
                                          context, const CricketLoginPlayer());
                                    },
                                    onTap1: () {
                                      THelperFunction.navigatedToScreen(
                                          context, const CricketLoginOrganization());

                                    },
                                  ));
                            },
                            onTap1: () {
                              THelperFunction.navigatedToScreen(
                                  context,
                                  ChooseCategory(
                                    title: STexts.swimmingPlayer,
                                    title1: STexts.swimmingOrganization,
                                    image: TImageString.swimmingPlayerImage,
                                    image1: TImageString.organization,
                                    onTap: () {
                                      THelperFunction.navigatedToScreen(
                                          context, const SwimmingPlayerLogin());
                                    },
                                    onTap1: () {
                                      THelperFunction.navigatedToScreen(context,
                                          const SwimmingLoginOrganization());
                                    },
                                  ));
                            },
                          ));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
