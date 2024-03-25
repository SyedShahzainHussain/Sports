import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sports/common/widget/verify_screen/verify_screen.dart';
import 'package:sports/features/authentication/model/user_model.dart';
import 'package:sports/features/authentication/view/modules/player/views/swimming_player/swimming_player.dart';
import 'package:sports/features/authentication/view/modules/player/views/swimming_player/widget/swimming_player_cnic_doc.dart';
import 'package:sports/repository/post_repo.dart';
import 'package:sports/services/user_view_model.dart';
import 'package:sports/utils/constants/api_constants.dart';
import 'package:sports/utils/constants/storage_constant.dart';
import 'package:sports/utils/device/devices_utility.dart';
import 'package:sports/utils/helper/firebase_storage.dart';
import 'package:sports/utils/helper/helper_function.dart';
import 'package:http_parser/src/media_type.dart' show MediaType;
import 'package:sports/utils/local_storage/storage_utility.dart';

class SwimmingPlayerViewModel with ChangeNotifier {
  final PostRepository postRepository = PostRepository();
  final data = UserViewModel();
  // ! Swimming Player Sign Up Api
  bool _isSwimmingPlayerSignUpLoading = false;
  bool get isSwimmingPlayerSignUpLoading => _isSwimmingPlayerSignUpLoading;

  setSwimmingPlayerSignUpLoading(bool isSwimmingPlayerSignUpLoading) {
    _isSwimmingPlayerSignUpLoading = isSwimmingPlayerSignUpLoading;
    notifyListeners();
  }

  Future<void> swimmingPlayerSignUpApi(
      dynamic body, BuildContext context) async {
    TDeviceUtils.hideKeyboard(context);
    setSwimmingPlayerSignUpLoading(true);
    postRepository
        .postRepository(body, TAPiString.swimmingRegister)
        .then((value) {
      TStorageUtils.addEmailToPreference(body["email"]);
      if (kDebugMode) {
        print(value);
      }

      setSwimmingPlayerSignUpLoading(false);
      THelperFunction.navigatedToScreen(
          context, const SwimmingPlayerFormDocument());
      THelperFunction.showFlushBar(
          "Swimming Player Created", icon: null, context);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setSwimmingPlayerSignUpLoading(false);
    });
  }

  // ! Cricket Player Sign Up Api Update User

  bool _isSwimmingPlayerUpdateLoading = false;
  bool get isSwimmingPlayerUpdateLoading => _isSwimmingPlayerUpdateLoading;

  setSwimmingPlayerUpdateLoading(bool isSwimmingPlayerUpdateLoading) {
    _isSwimmingPlayerUpdateLoading = isSwimmingPlayerUpdateLoading;
    notifyListeners();
  }

  Future<void> swimmingPlayerSignUpApiUpdate(
    File file,
    BuildContext context,
    File frontImage,
    File backImage,
  ) async {
    TDeviceUtils.hideKeyboard(context);
    setSwimmingPlayerUpdateLoading(true);
    try {
      // Uploading PDF file
      final pdfUrl =
          await StorageModel().uploadImage("pdf", file, context, "application");
      String email = await TStorageUtils.getEmailToPreference();
      // Creating multipart request
      final request = MultipartRequest(
          "POST", Uri.parse(TAPiString.swimmingRegisterAllData));

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
        setSwimmingPlayerUpdateLoading(false);
        THelperFunction.navigatedToScreenWithPop(
            context, const VerifyPendingScreen());
        THelperFunction.showToast("Swimming Player Details Uploaded");
      } else if (response.statusCode == 400) {
        final errorResponse = await response.stream.bytesToString();
        final errorJson = jsonDecode(errorResponse);
        final errorMessage =
            errorJson['error'] ?? 'An unexpected error occurred';
        THelperFunction.showToast(errorMessage);
        setSwimmingPlayerUpdateLoading(false);
      } else {
        THelperFunction.showToast(response.reasonPhrase.toString());
        setSwimmingPlayerUpdateLoading(false);
      }
    } catch (e) {
      THelperFunction.showToast(e.toString());
      setSwimmingPlayerUpdateLoading(false);
    }
  }

  // ! Swimming Player Login  Api

  bool _isSwimmingPlayerLoginInLoading = false;
  bool get isSwimmingPlayerLoginInLoading => _isSwimmingPlayerLoginInLoading;

  setSwimmingPlayerLoginInLoading(bool isSwimmingPlayerLoginInLoading) {
    _isSwimmingPlayerLoginInLoading = isSwimmingPlayerLoginInLoading;
    notifyListeners();
  }

  Future<void> swimmingPlayerLoginInApi(
      dynamic body, BuildContext context) async {
    TDeviceUtils.hideKeyboard(context);
    setSwimmingPlayerLoginInLoading(true);
    postRepository.postRepository(body, TAPiString.swimmingLogin).then((value) {
      var user = UserModel.fromJson(value);
      data.saveUser(user.user!);
      data.saveUserType(StorageConstant.swimmingPlayer);
      if (kDebugMode) {
        print(value);
      }
      setSwimmingPlayerLoginInLoading(false);
      THelperFunction.navigatedToScreenWithPop(
          context, const SwimmingPlayerScreen());
      THelperFunction.showFlushBar(
          "Swimming Player Login Success", icon: null, context);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setSwimmingPlayerLoginInLoading(false);
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
