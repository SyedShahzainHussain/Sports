import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/features/authentication/view/modules/organization/viewModel/swimming_organization_view_model.dart';
import 'package:sports/features/authentication/view/modules/organization/views/swimming_organization/widget/swimming_organization_widget.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/helper/helper_function.dart';

class SwimmingRegisterOrganization extends StatelessWidget {
  const SwimmingRegisterOrganization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Swimming Organization"),
        showBackArrow: true,
      ),
      body: Consumer<SwimmingOrganizationViewModel>(
        builder: (context, value, _) => ModalProgressHUD(
          inAsyncCall: value.isSwimmingOrganizationSignUpLoading,
          progressIndicator: THelperFunction.showIndicator(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSized.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Organization Register",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: TSized.spacebetweenItem),
                  const SwimmingOrganizationForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
