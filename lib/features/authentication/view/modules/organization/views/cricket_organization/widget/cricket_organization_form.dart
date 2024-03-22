import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sports/common/widget/textfield/text_form_field_widget.dart';
import 'package:sports/common/widget/verify_screen/verify_screen.dart';
import 'package:sports/features/authentication/model/pdf_file_model.dart';
import 'package:sports/utils/constants/colors.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/helper/helper_function.dart';
import 'package:sports/utils/validator/validation.dart';

class CricketOrganizationForm extends StatefulWidget {
  const CricketOrganizationForm({super.key});

  @override
  State<CricketOrganizationForm> createState() =>
      _CricketOrganizationFormState();
}

class _CricketOrganizationFormState extends State<CricketOrganizationForm> {
  final countryController = TextEditingController();
  final nameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedValue;
  PdfFile? pdfFile;

  @override
  void initState() {
    super.initState();
  }

  void onSave() {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }

    if (_selectedValue == null || countryController.text.isEmpty) {
      // Check if the context is available within a Scaffold
      THelperFunction.showFlushBar("All Fields Are Required!", context);
    } else {
      THelperFunction.navigatedToScreen(
          context, const VerifyPendingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormFieldWidget(
              validator: (value) => SValidation.validateName(value),
              controller: nameController,
              keyboardType: TextInputType.text,
              labelText: "Organization Name",
              prefixIcon: const Icon(Iconsax.text),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormFieldWidget(
              validator: (value) => SValidation.validateEmail(value),
              controller: emailAddressController,
              keyboardType: TextInputType.emailAddress,
              labelText: "Organization Email",
              prefixIcon: const Icon(Icons.email),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormField(
              validator: (value) => SValidation.validatePassword(value),
              controller: passwordController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: "Organization Password",
              ),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormFieldWidget(
              maxLength: 11,
              validator: (value) => SValidation.validatePhoneNumber(value),
              controller: contactNumberController,
              keyboardType: TextInputType.number,
              labelText: "Organization Contact Number",
              prefixIcon: const Icon(Icons.phone),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormFieldWidget(
              validator: (value) => SValidation.validateAddress(value),
              controller: addressController,
              keyboardType: TextInputType.text,
              labelText: "Organization Head Office Location",
              prefixIcon: const Icon(Iconsax.location),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            GestureDetector(
              onTap: () {
                THelperFunction.showCountry(context, (country) {
                  setState(() {
                    countryController.text = country.name;
                  });
                });
              },
              child: TextFormField(
                controller: countryController,
                decoration: const InputDecoration(
                    labelText: "Organization Country Of Origin",
                    enabled: false),
              ),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            DropdownButtonFormField<String?>(
              hint: const Text("Selected Organization"),
              decoration: const InputDecoration(
                labelText: "Organization Type",
              ),
              value: _selectedValue, // set the initial value
              dropdownColor: TColors.accent,
              items: [
                DropdownMenuItem(
                  value: "National", // Unique value for this option
                  child: Text(
                    "National",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                DropdownMenuItem(
                  value: "International", // Unique value for this option
                  child: Text("International",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                DropdownMenuItem(
                  value: "Franchise", // Unique value for this option
                  child: Text("Franchise",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            const SizedBox(height: TSized.spacebetweenItem),
            Text(
              "Upload documents ",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: TSized.spacebetweenItem),
            Container(
              padding: const EdgeInsets.all(TSized.md),
              decoration: BoxDecoration(
                border: Border.all(color: TColors.primary),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      pdfFile = await THelperFunction.pickFilePdf(context);
                      setState(() {});
                    },
                    child: Material(
                      elevation: 4.0,
                      child: Container(
                        decoration:
                            const BoxDecoration(color: TColors.softGrey),
                        child: Padding(
                          padding: const EdgeInsets.all(TSized.xsm),
                          child: Text(
                            "Choose File",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: TSized.md),
                  Expanded(
                    child: Text(
                      pdfFile?.file.path.toString() ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: TSized.spacebetweenItem),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onSave();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: const BeveledRectangleBorder()),
                child: const Text("Submit"),
              ),
            )
          ],
        ));
  }
}
