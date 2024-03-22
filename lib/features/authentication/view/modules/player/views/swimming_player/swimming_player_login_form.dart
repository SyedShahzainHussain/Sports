import 'package:flutter/material.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/common/widget/textfield/text_form_field_widget.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';
import 'package:sports/utils/validator/validation.dart';

class SwimmingPlayerLogin extends StatefulWidget {
  const SwimmingPlayerLogin({super.key});

  @override
  State<SwimmingPlayerLogin> createState() => _SwimmingPlayerLoginState();
}

class _SwimmingPlayerLoginState extends State<SwimmingPlayerLogin> {
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onSave() {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    }
  }

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
                STexts.login,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSized.spacebetweenItem),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        validator: (value) =>
                            SValidation.validatePassword(value),
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            onSave();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: const BeveledRectangleBorder()),
                          child: const Text("Login"),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
