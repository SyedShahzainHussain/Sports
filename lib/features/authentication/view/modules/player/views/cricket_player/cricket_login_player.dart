import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/common/widget/textfield/text_form_field_widget.dart';
import 'package:sports/features/authentication/view/modules/player/viewModel/cricket_player_view_model.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';
import 'package:sports/utils/helper/helper_function.dart';
import 'package:sports/utils/validator/validation.dart';

class CricketLoginPlayer extends StatefulWidget {
  const CricketLoginPlayer({super.key});

  @override
  State<CricketLoginPlayer> createState() => _CricketLoginPlayerState();
}

class _CricketLoginPlayerState extends State<CricketLoginPlayer> {
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onSave() {
    final validate = _formKey.currentState!.validate();
    if (!validate) {
      return;
    } else {
      final body = {
        "email": emailAddressController.text.toString(),
        "password": passwordController.text.toString()
      };
      context
          .read<CricketPlayerViewModel>()
          .cricketPlayerLoginInApi(body, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Cricket Player"),
        showBackArrow: true,
      ),
      body: Consumer<CricketPlayerViewModel>(
        builder: (context,value,_)=>
        ModalProgressHUD(
          inAsyncCall: value.isCricketPlayerLoginInLoading,
          progressIndicator: THelperFunction.showIndicator(),
          child: SingleChildScrollView(
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
        ),
      ),
    );
  }
}
