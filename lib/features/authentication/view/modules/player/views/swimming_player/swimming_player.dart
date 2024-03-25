import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports/features/authentication/view/splash_screen/splash_screen.dart';
import 'package:sports/services/user_view_model.dart';
import 'package:sports/utils/helper/helper_function.dart';
class SwimmingPlayerScreen extends StatelessWidget {
  const SwimmingPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swimming Player"),
      ),
      body: Center(
        child: OutlinedButton(onPressed: () {
           context.read<UserViewModel>().remove().then((value) {
                            context.read<UserViewModel>().removeUserType();
                            THelperFunction.navigatedToScreenWithPop(
                                context, const SplashScreen());
                          });
        }, child: const Text("Logout")),
      ),
    );
  }
}
