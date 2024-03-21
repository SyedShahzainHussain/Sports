import 'package:flutter/material.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';


import 'package:sports/features/authentication/view/modules/player/views/swimming_player/widget/swimming_player_login_form.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';

class SwimmingPlayerScreen extends StatelessWidget {
  const SwimmingPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Swimming Player"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                STexts.register,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSized.spacebetweenItem),
              const SwimmingPlayerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
