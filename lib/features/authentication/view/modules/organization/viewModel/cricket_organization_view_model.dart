import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sports/common/widget/verify_screen/verify_screen.dart';
import 'package:sports/features/authentication/model/user_model.dart';
import 'package:sports/features/authentication/view/modules/organization/views/cricket_organization/cricket_organization.dart';
import 'package:sports/repository/post_repo.dart';
import 'package:sports/services/user_view_model.dart';
import 'package:sports/utils/constants/api_constants.dart';
import 'package:sports/utils/constants/storage_constant.dart';
import 'package:sports/utils/device/devices_utility.dart';
import 'package:sports/utils/helper/firebase_storage.dart';
import 'package:sports/utils/helper/helper_function.dart';

class CricketOrganizationViewModel with ChangeNotifier {
  final PostRepository postRepository = PostRepository();
  final data = UserViewModel();
  bool _isCricketOrganizationSignUpLoading = false;
  bool get isCricketOrganizationSignUpLoading =>
      _isCricketOrganizationSignUpLoading;

  setCricketOrganizationSignUpLoading(bool isCricketOrganizationSignUpLoading) {
    _isCricketOrganizationSignUpLoading = isCricketOrganizationSignUpLoading;
    notifyListeners();
  }

  // ! Cricket Organization Sign Up Api
  Future<void> cricketOrganizationSignUpApi(
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
    setCricketOrganizationSignUpLoading(true);
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
        .postRepository(body, TAPiString.cricketOrganizationRegister)
        .then((value) {
      if (kDebugMode) {
        print(value);
      }
      setCricketOrganizationSignUpLoading(false);
      THelperFunction.navigatedToScreenWithPop(
          context, const VerifyPendingScreen());
      THelperFunction.showFlushBar("Cricket Organization Register", context,
          icon: null);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setCricketOrganizationSignUpLoading(false);
      THelperFunction.showFlushBar(error.toString(), context,
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ));
    });
  }

  bool _isCricketOrganizationLoginInLoading = false;
  bool get isCricketOrganizationLoginInLoading =>
      _isCricketOrganizationLoginInLoading;

  setCricketOrganizationLoginInLoading(
      bool isCricketOrganizationLoginInLoading) {
    _isCricketOrganizationLoginInLoading = isCricketOrganizationLoginInLoading;
    notifyListeners();
  }

  // ! Cricket Organization Login  Api
  Future<void> cricketOrganizationLoginInApi(
      dynamic body, BuildContext context) async {
    TDeviceUtils.hideKeyboard(context);
    setCricketOrganizationLoginInLoading(true);
    postRepository
        .postRepository(body, TAPiString.cricketOrganizationLogin)
        .then((value) {
      var user = UserModel.fromJson(value);
      data.saveUser(user.user!);
      data.saveUserType(StorageConstant.cricketOrganization);

      if (kDebugMode) {
        print(value);
      }
      setCricketOrganizationLoginInLoading(false);
      THelperFunction.navigatedToScreenWithPop(
          context, const CricketOrganizationScreen());
      THelperFunction.showFlushBar(
          "Cricket Organization Login ",
          icon: null,
          context);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setCricketOrganizationLoginInLoading(false);
      if (error.toString() == "Unauthorized Request Admin not approved yet") {
        THelperFunction.navigatedToScreen(context, const VerifyPendingScreen());
      }
      THelperFunction.showFlushBar(error.toString(), context,
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ));
    });
  }
}
