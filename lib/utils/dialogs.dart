import 'dart:io';

import 'package:fl_structure/utils/common.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<void> customDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onTapYes,
}) async {
  RxBool showLoading = false.obs;
  await showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      insetAnimationCurve: Curves.linearToEaseOut,
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      content: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () => back(context),
          child: const Text(
            "No",
            style: TextStyle(fontSize: 15, color: primary),
          ),
        ),
        Obx(
          () => TextButton(
            onPressed: () {
              showLoading.value = true;
              onTapYes();
            },
            child: showLoading.value
                ? customLoader(width: 15, height: 15)
                : const Text(
                    "Yes",
                    style: TextStyle(color: primary, fontSize: 15),
                  ),
          ),
        ),
      ],
    ),
  ).then((value) => showLoading.value = false);
}

Future<void> showPickImageDialog({
  required BuildContext context,
  required bool imageReturn,
  required ValueChanged<File> selectedImage,
}) async {
  await showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.center,
      child: SizedBox(
        height: 150,
        width: 200,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox.shrink(),
                    Text(
                      "Profile photo",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox.shrink(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GeneralBtn(
                      title: "From gallery",
                      onTap: () async {
                        final image =
                            await getImage(context: context, fromGallery: true);
                            selectedImage(File(image?.path ?? ''));
                          if (!imageReturn) {
                            // context
                            //     .read<ImageSelectedToggleBloc>()
                            //     .add(image?.path ?? "");
                          }
                          back(context);
                      },
                    ),
                    GeneralBtn(
                      title: "Take photo",
                      onTap: () async {
                        final image = await getImage(
                            context: context, fromGallery: false);
                        selectedImage(File(image?.path ?? ''));
                        if (!imageReturn) {
                          // context
                          //     .read<ImageSelectedToggleBloc>()
                          //     .add(image?.path ?? "");
                        }
                        back(context);
                      },
                    ),
                  ],
                )
              ],
            ),
            // Positioned(
            //     top: 0,
            //     right: 0,
            //     child: IconButton(
            //       icon: imageContainer(
            //           width: 30,
            //           height: 30,
            //           showBorder: true,
            //           showImage: false,
            //           child: const Center(
            //             child: Icon(
            //               Icons.close_sharp,
            //               size: 20,
            //               color: Colors.black,
            //             ),
            //           ),
            //           imageUrl: ''),
            //       onPressed: () => back(context),
            //     ))
          ],
        ),
      ),
    ),
  );
}
