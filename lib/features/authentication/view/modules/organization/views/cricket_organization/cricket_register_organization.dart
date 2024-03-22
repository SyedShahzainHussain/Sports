import 'package:flutter/material.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/features/authentication/view/modules/organization/views/cricket_organization/widget/cricket_organization_form.dart';
import 'package:sports/utils/constants/size.dart';

class CricketRegisterOrganization extends StatelessWidget {
  const CricketRegisterOrganization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Cricket Organization"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
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
              const CricketOrganizationForm(),
            ],
          ),
        ),
      ),
    );
  }
}
