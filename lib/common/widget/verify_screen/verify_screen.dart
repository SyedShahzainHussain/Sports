import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sports/features/authentication/view/login_register/login_register.dart';
import 'package:sports/utils/constants/image_strings.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/device/devices_utility.dart';
import 'package:sports/utils/helper/helper_function.dart';

class VerifyPendingScreen extends StatelessWidget {
  const VerifyPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            THelperFunction.navigatedToScreenWithPop(
                context, const LoginRegister());
          },
          icon: const Icon(
            CupertinoIcons.clear,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              Image(
                width: TDeviceUtils.screenWidth(context) * 0.6,
                image: AssetImage(
                  TImageString.verificationPending,
                ),
              ),
              const SizedBox(
                height: TSized.spacebetweenSections,
              ),

              // ! Title & Subtitle

              Text(
                "Your account verification is pending",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              Text(
                "Your account verification is pending by the admin. Please wait for some time until the verification process is completed.",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: TSized.spacebetweenSections,
              ),
              // ! Button

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    THelperFunction.navigatedToScreenWithPop(
                        context, const LoginRegister());
                  },
                  child: const Text("Okay"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
