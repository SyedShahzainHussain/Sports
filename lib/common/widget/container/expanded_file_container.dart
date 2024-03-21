import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sports/utils/constants/colors.dart';

class ExpandedFileContainer extends StatelessWidget {
  final File? image;
  final Function? onPress;
  final Widget? widget;
  const ExpandedFileContainer(
      {super.key,
      required this.image,
      required this.onPress,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
          onPress!();
      },
      child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: TColors.primary),
              image: image == null
                  ? null
                  : DecorationImage(
                      image: FileImage(File(image!.path)), fit: BoxFit.cover)),
          child: image == null
              ? Center(
                  child: widget,
                )
              : const SizedBox()),
    ));
  }
}
