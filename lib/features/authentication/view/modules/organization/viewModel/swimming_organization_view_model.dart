import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sports/common/widget/verify_screen/verify_screen.dart';
import 'package:sports/features/authentication/model/user_model.dart';
import 'package:sports/features/authentication/view/modules/organization/views/swimming_organization/swimming_organization.dart';
import 'package:sports/repository/post_repo.dart';
import 'package:sports/services/user_view_model.dart';
import 'package:sports/utils/constants/api_constants.dart';
import 'package:sports/utils/constants/storage_constant.dart';
import 'package:sports/utils/device/devices_utility.dart';
import 'package:sports/utils/helper/firebase_storage.dart';
import 'package:sports/utils/helper/helper_function.dart';

class SwimmingOrganizationViewModel with ChangeNotifier {
  final PostRepository postRepository = PostRepository();
  final data = UserViewModel();
  bool _isSwimmingOrganizationSignUpLoading = false;
  bool get isSwimmingOrganizationSignUpLoading =>
      _isSwimmingOrganizationSignUpLoading;

  setSwimmingOrganizationSignUpLoading(
      bool isSwimmingOrganizationSignUpLoading) {
    _isSwimmingOrganizationSignUpLoading = isSwimmingOrganizationSignUpLoading;
    notifyListeners();
  }

  // ! Swimming Organization Sign Up Api
  Future<void> swimmingOrganizationSignUpApi(
      {required String name,
      required String email,
      required String password,
      required String number,
      required String address,
      required String country,
      required File file,
      required BuildContext context,
      required String selectedValue}) async {
    TDeviceUtils.hideKeyboard(context);
    setSwimmingOrganizationSignUpLoading(true);
    String? pdfUrl =
        await StorageModel().uploadImage("pdf", file, context, "application");

    final body = {
      "name": name,
      "email": email,
      "password": password,
      "number": number,
      "address": address,
      "pdf": pdfUrl,
      "country": country,
      "type": selectedValue,
    };
    postRepository
        .postRepository(body, TAPiString.swimmingOrganizationRegister)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      setSwimmingOrganizationSignUpLoading(false);
      THelperFunction.navigatedToScreenWithPop(
          context, const VerifyPendingScreen());
      THelperFunction.showFlushBar(
          "Swimming Organization Register", icon: null, context);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setSwimmingOrganizationSignUpLoading(false);
      THelperFunction.showFlushBar(
          error.toString(),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          context);
    });
  }

  // ! Swimming Organization Login  Api

  bool _isSwimmingOrganizationLoginInLoading = false;
  bool get isSwimmingOrganizationLoginInLoading =>
      _isSwimmingOrganizationLoginInLoading;

  setSwimmingOrganizationLoginInLoading(
      bool isSwimmingOrganizationLoginInLoading) {
    _isSwimmingOrganizationLoginInLoading =
        isSwimmingOrganizationLoginInLoading;
    notifyListeners();
  }

  Future<void> swimmingOrganizationLoginInApi(
      dynamic body, BuildContext context) async {
    TDeviceUtils.hideKeyboard(context);
    setSwimmingOrganizationLoginInLoading(true);
    postRepository
        .postRepository(body, TAPiString.swimmingOrganizationLogin)
        .then((value) {
      var user = UserModel.fromJson(value);
      data.saveUser(user.user!);
      data.saveUserType(StorageConstant.swimmingOrganization);
      if (kDebugMode) {
        print(value);
      }
      setSwimmingOrganizationLoginInLoading(false);
      THelperFunction.navigatedToScreenWithPop(
          context, const SwimmingOrganizationScreen());
      THelperFunction.showFlushBar(
          "Swimming Organization Login ", icon: null, context);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setSwimmingOrganizationLoginInLoading(false);
      if (error.toString() == "Unauthorized Request Admin not approved yet") {
        THelperFunction.navigatedToScreen(context, const VerifyPendingScreen());
      }
      THelperFunction.showFlushBar(
          error.toString(),
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          context);
    });
  }
}
