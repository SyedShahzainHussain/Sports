import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports/features/authentication/model/pdf_file_model.dart';
import 'package:sports/utils/constants/colors.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/constants/texts.dart';

class THelperFunction {
  THelperFunction._();

  static Color? getColor(String value) {
    value = value.toLowerCase();
    if (value == "green") {
      return Colors.green;
    } else if (value == "red") {
      return Colors.red;
    } else if (value == "blue") {
      return Colors.blue;
    } else if (value == "purple") {
      return Colors.purple;
    } else if (value == "pink") {
      return Colors.pink;
    } else if (value == "grey") {
      return Colors.grey;
    } else if (value == "black") {
      return Colors.black;
    } else if (value == "white") {
      return Colors.white;
    } else {
      return null;
    }
  }

  static showSnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlertDialog(
      String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"))
              ],
            ));
  }

  static void showBottomSheet(
    BuildContext context,
    Function()? pickImage,
    Function()? pickGallery,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(TSized.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    pickImage!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.camera),
                        const SizedBox(
                          width: TSized.spacebetweenItem,
                        ),
                        Text(
                          STexts.camera,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: TSized.spacebetweenItem,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    pickGallery!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.image),
                        const SizedBox(
                          width: TSized.spacebetweenItem,
                        ),
                        Text(
                          STexts.gallery,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void navigatedToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void navigatedToScreenWithPop(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (context) => false,
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static Future<void> showToast(String msg) async {
    await Fluttertoast.showToast(
      msg: msg,
    );
  }

  static void showFlushBar(String msg, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(TSized.defaultSpace),
      borderRadius: BorderRadius.circular(TSized.cardRadiusXsm),
      icon: const Icon(Icons.error,color: Colors.red,),
      message: msg,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static Widget showIndicator([double? size = 50]) {
    return SpinKitChasingDots(
      color: TColors.primary,
      size: size!,
    );
  }

  static Future<File> pickImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);

    return File(image!.path);
  }

  static Future<File> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    return File(image!.path);
  }

  static Future<PdfFile?> pickFilePdf(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: [
          'pdf','doc','png','jpeg'
        ],
        type: FileType.custom,
      );
      if (result == null) {
        return null;
      }

      List<File> files = result.files.map((file) => File(file.path!)).toList();
      if (files.isEmpty) {
        return null;
      }

      File file = files.first;
      final pdfFile = PdfFile(file: file, filePath: file.path);
      showToast("Pdf Selected");
      return pdfFile;
    } catch (e) {
      showToast("Error picking file: $e");
      return null;
    }
  }

  static void showCountry(BuildContext context, Function(Country) onSelect) {
    return showCountryPicker(
        context: context,
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          bottomSheetHeight: 500, // Optional. Country list modal height
          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: onSelect);
  }
}
