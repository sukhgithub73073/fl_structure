import 'package:bot_toast/bot_toast.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

part 'no_data_found_widget.dart';
part 'general_btn.dart';

void toast({required String msg, bool isError = true}) {
  BotToast.showCustomText(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) => Align(
        alignment: const Alignment(0, 0.8),
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4.0,
                  spreadRadius: 0.0,
                  offset: const Offset(
                    0.0,
                    2.0,
                  ),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isError
                          ? Colors.red.withOpacity(0.2)
                          : Colors.green.withOpacity(0.2),
                    ),
                    child: Icon(
                      isError ? Icons.error : Icons.done_all,
                      color: isError ? Colors.red : Colors.green,
                    ),
                  ),
                  xWidth(10),
                  Flexible(
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isError ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                  xWidth(10),
                ],
              ),
            ],
          ),
        ),
      ));
}


Widget customListViewShimmer({required int itemCount, double? boxHeight}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (c, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: double.infinity,
              color: white,
            ),
          );
        }),
  );
}

Widget customBoxShimmer({double? boxHeight, double? boxWidth, double? borderRadius}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: boxHeight ?? 50,
      width: boxWidth ?? double.infinity,
      decoration: BoxDecoration(
          color: white,
        borderRadius: BorderRadius.circular(borderRadius??0)
      ),
    ),
  );
}
