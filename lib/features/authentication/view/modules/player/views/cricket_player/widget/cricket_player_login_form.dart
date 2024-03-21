import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sports/common/widget/textfield/text_form_field_widget.dart';
import 'package:sports/features/authentication/view/modules/player/views/cricket_player/widget/cricket_player_cnic_doc.dart';
import 'package:sports/utils/constants/colors.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:sports/utils/helper/helper_function.dart';
import 'package:sports/utils/helper/pakistan_cnic_input_formatter.dart';
import 'package:sports/utils/validator/validation.dart';

class CricketPlayerForm extends StatefulWidget {
  const CricketPlayerForm({super.key});

  @override
  State<CricketPlayerForm> createState() => _CricketPlayerFormState();
}

class _CricketPlayerFormState extends State<CricketPlayerForm> {
  final countryController = TextEditingController();
  final nameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final cnicController = TextEditingController();
  final contactNumberController = TextEditingController();
  final addressController = TextEditingController();
  final organizationTextController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool? _isMale;
  String? _selectedValue;
  String? dateOfBirth;

  @override
  void initState() {
    super.initState();
    _selectedValue = "Under 13"; // Set the initial value here
  }

  @override
  void dispose() {
    super.dispose();
    countryController.dispose();
    nameController.dispose();
    emailAddressController.dispose();
    cnicController.dispose();
    contactNumberController.dispose();
    addressController.dispose();
    organizationTextController.dispose();
    passwordController.dispose();
  }

  void onSave() {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }

    if (_selectedValue == null ||
        countryController.text.isEmpty ||
        _isMale == null) {
      // Check if the context is available within a Scaffold
      THelperFunction.showFlushBar("All Fields Are Required!", context);
    } else if (dateOfBirth == null) {
      THelperFunction.showFlushBar("Date of birth is required", context);
    } else {
      THelperFunction.navigatedToScreen(
          context, const CricketPlayerDocumentScreen());
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
              labelText: "Name",
              prefixIcon: const Icon(Iconsax.text),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormFieldWidget(
              validator: (value) => SValidation.validateEmail(value),
              controller: emailAddressController,
              keyboardType: TextInputType.emailAddress,
              labelText: "Email Address",
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
                labelText: "Password",
              ),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            DOBInputField(
              fieldLabelText: "Date Of Birth",
              firstDate: DateTime(1900),
              showLabel: true,
              lastDate: DateTime.now(),
              onDateSubmitted: (value) {
                setState(() {
                  dateOfBirth =
                      '${DateTime(value.year, value.month, value.day)}';
                });
              },
              onDateSaved: (value) {
                setState(() {
                  dateOfBirth =
                      '${DateTime(value.year, value.month, value.day)}';
                });
              },
              inputDecoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Iconsax.calendar),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormField(
              validator: (value) => SValidation.cnicValidate(value),
              controller: cnicController,
              maxLength: 15,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.card),
                labelText: "CNIC 00000-0000000-0",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                PakistanCnicInputFormatter()
              ],
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormFieldWidget(
              maxLength: 11,
              validator: (value) => SValidation.validatePhoneNumber(value),
              controller: contactNumberController,
              keyboardType: TextInputType.number,
              labelText: "Contact Number",
              prefixIcon: const Icon(Icons.phone),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormFieldWidget(
              validator: (value) => SValidation.validateAddress(value),
              controller: addressController,
              keyboardType: TextInputType.text,
              labelText: "Address",
              prefixIcon: const Icon(Iconsax.location),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            TextFormFieldWidget(
              validator: (value) => SValidation.validateOrganization(value),
              controller: organizationTextController,
              keyboardType: TextInputType.text,
              labelText: "Organizations Currently Affiliated With",
              prefixIcon: const Icon(Iconsax.info_circle),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            // ! Category
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: "Category",
              ),
              value: _selectedValue, // set the initial value
              dropdownColor: TColors.accent,
              items: [
                DropdownMenuItem(
                  value: "Under 13", // Unique value for this option
                  child: Text(
                    "Under 13",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                DropdownMenuItem(
                  value: "Under 15", // Unique value for this option
                  child: Text("Under 15",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                DropdownMenuItem(
                  value: "Under 19", // Unique value for this option
                  child: Text("Under 19",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                DropdownMenuItem(
                  value: "Above 19", // Unique value for this option
                  child: Text("Above 19",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
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
                    labelText: "Selected Country", enabled: false),
              ),
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),

            // ! Select Gender
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selected Gender",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text("Male"),
                        value: true,
                        groupValue: _isMale,
                        onChanged: (value) {
                          setState(() {
                            _isMale = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text("Female"),
                        value: false,
                        groupValue: _isMale,
                        onChanged: (value) {
                          setState(() {
                            _isMale = value;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onSave();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: const BeveledRectangleBorder()),
                child: const Text("Register"),
              ),
            )
          ],
        ));
  }
}
