import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/features/authentication/view/modules/player/viewModel/cricket_player_view_model.dart';
import 'package:sports/features/authentication/view/modules/player/views/cricket_player/widget/cricket_player_register_form.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sports/utils/helper/helper_function.dart';

class CricketRegisterPlayer extends StatelessWidget {
  const CricketRegisterPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: Text("Cricket Player"),
        showBackArrow: true,
      ),
      body: Consumer<CricketPlayerViewModel>(
        builder: (context, value, _) => ModalProgressHUD(
          inAsyncCall: value.isCricketPlayerSignUpLoading,
          progressIndicator: THelperFunction.showIndicator(),
          child: SingleChildScrollView(
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
                  const CricketPlayerForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
