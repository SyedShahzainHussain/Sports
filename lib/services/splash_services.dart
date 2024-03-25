import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sports/features/authentication/model/user_model.dart";
import "package:sports/features/authentication/view/login_register/login_register.dart";
import "package:sports/features/authentication/view/modules/organization/views/cricket_organization/cricket_organization.dart";
import "package:sports/features/authentication/view/modules/organization/views/swimming_organization/swimming_organization.dart";
import "package:sports/features/authentication/view/modules/player/views/cricket_player/cricket_player.dart";
import "package:sports/features/authentication/view/modules/player/views/swimming_player/swimming_player.dart";
import "package:sports/services/user_view_model.dart";
import "package:sports/utils/constants/storage_constant.dart";
import "package:sports/utils/helper/helper_function.dart";

class SplashServices {
  Future<User> getUserData() => UserViewModel().getUser();
  void checkAuthentication(BuildContext context) async {
    final dp = await SharedPreferences.getInstance();
    final userType = dp.getString("userType");
    getUserData().then((value) {
      if (userType == StorageConstant.cricketPlayer) {
        THelperFunction.navigatedToScreenWithPop(
            context, const CricketPlayerScreen());
      } else if (userType == StorageConstant.cricketOrganization) {
        THelperFunction.navigatedToScreenWithPop(
            context, const CricketOrganizationScreen());
      } else if (userType == StorageConstant.swimmingPlayer) {
        THelperFunction.navigatedToScreenWithPop(
            context, const SwimmingPlayerScreen());
      } else if (userType == StorageConstant.swimmingOrganization) {
        THelperFunction.navigatedToScreenWithPop(
            context, const SwimmingOrganizationScreen());
      } else {
        THelperFunction.navigatedToScreenWithPop(
            context, const LoginRegister());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
