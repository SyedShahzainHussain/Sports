import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sports/common/widget/container/expanded_file_container.dart';
import 'package:sports/common/widget/appBar/custom_appbar.dart';
import 'package:sports/features/authentication/model/pdf_file_model.dart';
import 'package:sports/features/authentication/view/modules/player/viewModel/cricket_player_view_model.dart';
import 'package:sports/utils/constants/colors.dart';
import 'package:sports/utils/constants/size.dart';
import 'package:sports/utils/helper/helper_function.dart';

class CricketPlayerDocumentScreen extends StatefulWidget {
  const CricketPlayerDocumentScreen({super.key});

  @override
  State<CricketPlayerDocumentScreen> createState() =>
      _CricketPlayerDocumentState();
}

class _CricketPlayerDocumentState extends State<CricketPlayerDocumentScreen> {
  File? frontImage;
  File? backImage;
  PdfFile? pdfFile;

  onSave() {
    if (frontImage == null || backImage == null || pdfFile == null) {
      THelperFunction.showFlushBar("All are required",icon: const Icon(
        Icons.error,
        color: Colors.red,
      ), context);
    } else {
      context.read<CricketPlayerViewModel>().cricketPlayerSignUpApiUpdate(
          pdfFile!.file, context, frontImage!, backImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Upload Documents"),
      ),
      body: Consumer<CricketPlayerViewModel>(
        builder: (context, value, _) => ModalProgressHUD(
          inAsyncCall: value.isCricketPlayerUpdateLoading,
          progressIndicator: THelperFunction.showIndicator(),
          child: Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload Cnic Image",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: TSized.spacebetweenItem),
                Row(
                  children: [
                    ExpandedFileContainer(
                      image: frontImage,
                      widget: Text(
                        "Enter Front Image",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onPress: () {
                        THelperFunction.showBottomSheet(context, () async {
                          frontImage =
                              await THelperFunction.pickImageFromCamera();
                          setState(() {});
                        }, () async {
                          frontImage =
                              await THelperFunction.pickImageFromGallery();
                          setState(() {});
                        });
                      },
                    ),
                    const SizedBox(width: TSized.spacebetweenItem),
                    ExpandedFileContainer(
                      image: backImage,
                      widget: Text(
                        "Enter Back Image",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onPress: () {
                        THelperFunction.showBottomSheet(context, () async {
                          backImage =
                              await THelperFunction.pickImageFromCamera();
                          setState(() {});
                        }, () async {
                          backImage =
                              await THelperFunction.pickImageFromGallery();
                          setState(() {});
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: TSized.spacebetweenItem),
                Text(
                  "Upload documents ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: TSized.spacebetweenItem),
                Container(
                  padding: const EdgeInsets.all(TSized.md),
                  decoration: BoxDecoration(
                    border: Border.all(color: TColors.primary),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() async {
                            pdfFile =
                                await THelperFunction.pickFilePdf(context);
                          });
                        },
                        child: Material(
                          elevation: 4.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: THelperFunction.isDarkMode(context)
                                    ? TColors.white
                                    : TColors.softGrey),
                            child: Padding(
                              padding: const EdgeInsets.all(TSized.xsm),
                              child: Text(
                                "Choose File",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: TSized.md),
                      Expanded(
                        child: Text(
                          pdfFile?.file.path.toString() ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
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
                    child: const Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
