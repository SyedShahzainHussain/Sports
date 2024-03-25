import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sports/common/widget/verify_screen/verify_screen.dart';
import 'package:sports/features/authentication/model/user_model.dart';
import 'package:sports/features/authentication/view/modules/player/views/cricket_player/cricket_player.dart';
import 'package:sports/features/authentication/view/modules/player/views/cricket_player/widget/cricket_player_cnic_doc.dart';
import 'package:sports/repository/post_repo.dart';
import 'package:sports/services/user_view_model.dart';
import 'package:sports/utils/constants/api_constants.dart';
import 'package:sports/utils/constants/storage_constant.dart';
import 'package:sports/utils/device/devices_utility.dart';
import 'package:sports/utils/helper/firebase_storage.dart';
import 'package:sports/utils/helper/helper_function.dart';
import 'package:http_parser/src/media_type.dart' show MediaType;
import 'package:sports/utils/local_storage/storage_utility.dart';

class CricketPlayerViewModel with ChangeNotifier {
  final PostRepository postRepository = PostRepository();
  final data = UserViewModel();

  // ! Cricket Player Sign Up Api
  bool _isCricketPlayerSignUpLoading = false;
  bool get isCricketPlayerSignUpLoading => _isCricketPlayerSignUpLoading;

  setCricketPlayerSignUpLoading(bool isCricketPlayerSignUpLoading) {
    _isCricketPlayerSignUpLoading = isCricketPlayerSignUpLoading;
    notifyListeners();
  }

  Future<void> cricketPlayerSignUpApi(
      dynamic body, BuildContext context) async {
    TDeviceUtils.hideKeyboard(context);
    setCricketPlayerSignUpLoading(true);
    postRepository
        .postRepository(body, TAPiString.cricketRegister)
        .then((value) {
      TStorageUtils.addEmailToPreference(body["email"]);
      if (kDebugMode) {
        print(value);
      }
      setCricketPlayerSignUpLoading(false);
      THelperFunction.navigatedToScreen(
          context, const CricketPlayerDocumentScreen());
      THelperFunction.showFlushBar(
          "Cricket Player Created", icon: null, context);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setCricketPlayerSignUpLoading(false);
    });
  }

  // ! Cricket Player Sign Up Api Update User

  bool _isCricketPlayerUpdateLoading = false;
  bool get isCricketPlayerUpdateLoading => _isCricketPlayerUpdateLoading;

  setCricketPlayerUpdateLoading(bool isCricketPlayerUpdateLoading) {
    _isCricketPlayerUpdateLoading = isCricketPlayerUpdateLoading;
    notifyListeners();
  }

  Future<void> cricketPlayerSignUpApiUpdate(
    File file,
    BuildContext context,
    File frontImage,
    File backImage,
  ) async {
    TDeviceUtils.hideKeyboard(context);
    setCricketPlayerUpdateLoading(true);
    try {
      // Uploading PDF file
      final pdfUrl =
          await StorageModel().uploadImage("pdf", file, context, "application");
      String email = await TStorageUtils.getEmailToPreference();
      // Creating multipart request
      final request = MultipartRequest(
          "POST", Uri.parse(TAPiString.cricketRegisterAllData));

      // Processing first image
      String image1Ext = frontImage.path.split(".").last;
      var file1 = await MultipartFile.fromPath("images", frontImage.path,
          contentType: MediaType("images", image1Ext));

      // Processing second image
      String image2Ext = backImage.path.split(".").last;
      var file2 = await MultipartFile.fromPath("images", backImage.path,
          contentType: MediaType("images", image2Ext));

      // Adding data to request
      request.fields["pdf"] = pdfUrl.toString();
      request.fields["email"] = email;
      request.files.add(file1);
      request.files.add(file2);

      // Sending request
      var response = await request.send();

      // Handling response
      if (response.statusCode == 201) {
        final responseJson = await response.stream.bytesToString();
        if (kDebugMode) {
          print(responseJson);
        }
        setCricketPlayerUpdateLoading(false);
        THelperFunction.navigatedToScreenWithPop(
            context, const VerifyPendingScreen());
        THelperFunction.showToast("Cricket Player Details Uploaded");
      } else if (response.statusCode == 400) {
        final errorResponse = await response.stream.bytesToString();
        final errorJson = jsonDecode(errorResponse);
        final errorMessage =
            errorJson['error'] ?? 'An unexpected error occurred';
        THelperFunction.showToast(errorMessage);
        setCricketPlayerUpdateLoading(false);
      } else {
        THelperFunction.showToast(response.reasonPhrase.toString());
        setCricketPlayerUpdateLoading(false);
      }
    } catch (e) {
      THelperFunction.showToast(e.toString());
      setCricketPlayerUpdateLoading(false);
    }
  }

  // ! Cricket Player Login  Api

  bool _isCricketPlayerLoginInLoading = false;
  bool get isCricketPlayerLoginInLoading => _isCricketPlayerLoginInLoading;

  setCricketPlayerLoginInLoading(bool isCricketPlayerLoginInLoading) {
    _isCricketPlayerLoginInLoading = isCricketPlayerLoginInLoading;
    notifyListeners();
  }

  Future<void> cricketPlayerLoginInApi(
      dynamic body, BuildContext context) async {
    TDeviceUtils.hideKeyboard(context);
    setCricketPlayerLoginInLoading(true);
    postRepository.postRepository(body, TAPiString.cricketLogin).then((value) {
      var user = UserModel.fromJson(value);
      data.saveUser(user.user!);
      data.saveUserType(StorageConstant.cricketPlayer);
      if (kDebugMode) {
        print(value);
      }
      setCricketPlayerLoginInLoading(false);
      THelperFunction.navigatedToScreenWithPop(
          context, const CricketPlayerScreen());
      THelperFunction.showFlushBar(
          "Cricket Player Login Success", icon: null, context);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setCricketPlayerLoginInLoading(false);
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
