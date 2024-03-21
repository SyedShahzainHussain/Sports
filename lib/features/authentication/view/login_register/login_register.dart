import 'package:flutter/material.dart';
import 'package:sports/common/widget/container/circular_container.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/features/authentication/view/choose_your_sport/choose_your_sport.dart';
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
                          context, const ChooseYourSports());
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
                      THelperFunction.showFlushBar("Login Work Processing", context);
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
