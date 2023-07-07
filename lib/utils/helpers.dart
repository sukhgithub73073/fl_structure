import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fl_structure/utils/all_getter.dart';
import 'package:fl_structure/utils/assets_paths.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common.dart';

part 'common_widgets.dart';

part 'field_deco.dart';

String trans(BuildContext context, String s) {
  return s;
}

const Color cardBgColor = Color(0xff363636);
const Color colorB58D67 = Color(0xffB58D67);
const Color colorE5D1B2 = Color(0xffE5D1B2);
const Color colorF9EED2 = Color(0xffF9EED2);
const Color colorFFFFFD = Color(0xffFFFFFD);

double topHeight = 0.10;
const Color primary = Color(0xFF1E54BA);
const Color secondary = Color(0xFF384199);
Color black = Colors.black;
Color white = Colors.white;

Color get grey => Colors.grey;

MaterialColor get deepOrange => Colors.deepOrange;

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

void exit() {
  SystemNavigator.pop();
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

SizedBox yHeight(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox xWidth(double width) {
  return SizedBox(
    width: width,
  );
}

/// Navigator functions
void pushTo(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void pushReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void back(BuildContext context) {
  Navigator.pop(context);
}

void printLog(dynamic msg) {
  _printLog('\x1B[32m() => ${msg.toString()}\x1B[0m');
}

void functionLog({required dynamic msg, required dynamic fun}) {
  _printLog("\x1B[31m${fun.toString()} ::==> ${msg.toString()}\x1B[0m");
}

void _printLog(dynamic msg) {
  if (kDebugMode) {
    debugPrint(msg.toString());
  }
}

void blocLog({required String msg, required String bloc}) {
  _printLog("\x1B[31m${bloc.toString()} ::==> ${msg.toString()}\x1B[0m");
}

/// field decoration
InputDecoration fieldDeco({
  String? labelText,
  TextStyle? labelStyle,
  String? hintText,
  bool? showSuffixIcon,
  Widget? suffix,
  bool? showPrefixIcon,
  Color? borderSideColor,
  Widget? prefix,
}) {
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: borderSideColor ?? primary)),
    prefixIcon: (showPrefixIcon ?? false) ? prefix : null,
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: borderSideColor ?? primary)),
    labelStyle:
        labelStyle ?? const TextStyle(color: Colors.black38, fontSize: 21),
    suffixIcon: (showSuffixIcon ?? false) ? suffix : null,
    suffixIconColor: primary,
    labelText: labelText,
    hintText: hintText,
  );
}
//
// /// Circular image
// Widget imageContainer(
//     {required String imageUrl,
//     double? height,
//     double? borderRadius,
//     Color? borderColor,
//     double? borderWidth,
//     Color? backgroundColor,
//     bool? showBorder,
//     bool? fromFile,
//     bool? fromNetwork,
//     bool? showImage = true,
//     double? width,
//     Widget? child}) {
//   return BlocBuilder<ImageErrorToggleBloc, bool>(
//     builder: (context, imageError) {
//       return Container(
//         height: height ?? 90,
//         width: width ?? 90,
//         decoration: BoxDecoration(
//             color: backgroundColor,
//             border: (showBorder ?? false)
//                 ? Border.all(
//                     color: borderColor ?? primary, width: borderWidth ?? 2)
//                 : null,
//             borderRadius: BorderRadius.circular(
//               borderRadius ?? 100,
//             ),
//             image: (showImage ?? false)
//                 ? DecorationImage(
//                     image: showSelectedImage(
//                       fromFile: fromFile,
//                       fromNetwork: fromNetwork,
//                       imageError: imageError,
//                       imageUrl: imageUrl,
//                     ),
//                     fit: BoxFit.cover,
//                     onError: (Object e, StackTrace? stackTrace) {
//                       context.read<ImageErrorToggleBloc>().add(true);
//                     },
//                   )
//                 : null),
//         child: child,
//       );
//     },
//   );
// }
//
// /// Circular image
// Widget cachedNetworkImage({
//   required String imageUrl,
//   required BuildContext context,
//   double? height,
//   double? borderRadius = 100,
//   Color? borderColor,
//   double? borderWidth,
//   Color? backgroundColor,
//   bool? showBorder,
//   double? width,
// }) {
//   printLog(borderRadius);
//   return Container(
//     height: height ?? 90,
//     width: width ?? 90,
//     decoration: BoxDecoration(
//       // color: imageUrl.isNotEmpty ? null : Colors.grey,
//       border: (showBorder ?? false)
//           ? Border.all(color: borderColor ?? primary, width: borderWidth ?? 2)
//           : null,
//       borderRadius: BorderRadius.circular(((borderRadius ?? 0) + 2)),
//     ),
//     child: ClipRRect(
//         borderRadius: BorderRadius.circular((borderRadius ?? 0)),
//         child: imageUrl.isEmpty
//             ? Image.asset(
//                 AssetsPath.defaultUser,
//                 fit: BoxFit.cover,
//               )
//             : CachedNetworkImage(
//                 imageUrl: imageUrl,
//                 fit: BoxFit.cover,
//                 progressIndicatorBuilder: (context, url, progress) => Center(
//                   child: CircularProgressIndicator(
//                     color: primary,
//                     value: progress.progress,
//                   ),
//                 ),
//                 errorWidget: (c, o, s) {
//                   return Image.asset(
//                     AssetsPath.imageNotFound,
//                     fit: BoxFit.cover,
//                   );
//                 },
//               )),
//   );
// }
//
// ImageProvider<Object> showSelectedImage({
//   bool? fromFile,
//   bool? fromNetwork,
//   required bool imageError,
//   required String imageUrl,
// }) {
//   if (fromNetwork ?? false) {
//     return NetworkImage(imageUrl);
//   } else {
//     if (fromFile ?? false) {
//       return Image.file(
//         File(imageUrl),
//         errorBuilder: (c, o, s) {
//           return Image.asset(AssetsPath.defaultUser);
//         },
//       ).image;
//     } else {
//       return const AssetImage(AssetsPath.defaultUser);
//     }
//   }
// }

Widget customLoader({
  double height = 25,
  double width = 25,
  Color color = Colors.black,
  double? value,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: CircularProgressIndicator(
      color: color,
      value: value,
    ),
  );
}

/// This function checks for location permission and returns the current position if
/// permission is granted.
Future<Position?> currentPosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      toast(
        msg: "Location Not Available",
      );
      // return Future.error('Location Not Available');
    }
  } else if (permission == LocationPermission.deniedForever) {
    return null;
  }
  // else {
  //   throw Exception('Error');
  // }
  return await Geolocator.getCurrentPosition();
}
// Future<dynamic> currentPosition() async {
//   try {
//     // PermissionStatus? permissionResult;
//     // permissionResult = await Permission.location.status;
//     // if (permissionResult.isDenied) {
// // await Permission.location.request();
//     //   if (permissionResult.isGranted) {
//     //     return await Geolocator.getCurrentPosition();
//     //   }
//     // } else if (permissionResult.isGranted) {
//     await Geolocator.requestPermission();
//       return await Geolocator.getCurrentPosition(forceAndroidLocationManager: true,
//           desiredAccuracy: LocationAccuracy.lowest);
//     // } else if (permissionResult.isPermanentlyDenied) {
//     //   toast(
//     //     msg:
//     //         "Location permissions are permanently denied, Please allow location permission",
//     //   );
//     //   await openAppSettings();
//     // } else {
//     //   toast(
//     //     msg: "Please check location permission",
//     //   );
//     // }
//     return null;
//   } catch (e) {
//     functionLog(msg: e.toString(), fun: "currentPosition");
//     return e.toString();
//   }
// }

/// get address from lat long
/// This function takes a position and returns the corresponding address using
/// Google Maps API.
Future<GeoData?> getAddress(Position? pos) async {
  try {
    return await Geocoder2.getDataFromCoordinates(
        latitude: pos?.latitude ?? 0,
        longitude: pos?.longitude ?? 0,
        googleMapApiKey: "AIzaSyBM1lxG5A0vRswCsnaQJnzyLMsqgowaym0");
  } catch (e) {
    functionLog(msg: e.toString(), fun: "getAddress");
    return null;
  }
}

/// get Image
Future<CroppedFile?> getImage({
  required BuildContext context,
  required bool fromGallery,
  bool cropPhoto = true,
}) async {
  try {
    final ImagePicker picker = ImagePicker();
    if (fromGallery) {
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if(cropPhoto) {
          CroppedFile? croppedFile = await cropImage(image, context);
          return croppedFile;
        }else{
          return CroppedFile(image.path);
        }
      }
    } else {
      var status = Permission.camera;
      printLog("camera status====${await status.isDenied}");
      if (await status.isGranted) {
        final XFile? photo = await picker.pickImage(source: ImageSource.camera);
        if (photo != null) {
          if(cropPhoto) {
            CroppedFile? croppedFile = await cropImage(photo, context);
            return croppedFile;
          }else{
            return CroppedFile(photo.path);
          }
        }
      } else if (await status.isPermanentlyDenied) {
        toast(msg: "Please allow camera permission");
        openAppSettings();
      } else {
        final res = await Permission.camera.request();
        if (res.isGranted) {
          final XFile? photo =
              await picker.pickImage(source: ImageSource.camera);
          if(cropPhoto) {
            CroppedFile? croppedFile = await cropImage(photo, context);
            return croppedFile;
          }else{
            return CroppedFile(photo?.path??"");
          }
        } else if (await status.isDenied) {
          toast(msg: "Please allow camera permission");
        }
      }
    }
    return null;
  } catch (e) {
    functionLog(fun: "getImage", msg: e.toString());
    return null;
  }
}

/// get Image
Future<List<File>?> getMultipleImages({required BuildContext context}) async {
  try {
    final ImagePicker picker = ImagePicker();

    final List<XFile> photo = await picker.pickMultiImage();
    List<File> images = <File>[];
    for (var element in photo) {
      images.add(File(element.path));
    }
    return images;
  } catch (e) {
    functionLog(fun: "getMultipleImages", msg: e.toString());
    return null;
  }
}

/// crop image
Future<CroppedFile?> cropImage(XFile? image, BuildContext context) async {
  try {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image?.path ?? "",
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop Image',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return croppedFile;
  } catch (e) {
    functionLog(fun: "cropImage", msg: e.toString());
    return null;
  }
}

Future<DateTime?> commonDatePicker(BuildContext context) async {
  try {
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1947),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: primary,
                onPrimary: white,
                onSurface: black // body text color
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: primary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return date;
  } catch (e) {
    functionLog(fun: "commonDatePicker", msg: e.toString());
    return null;
  }
}

Widget getOnlineUserDot(bool userIsOnlineOffline) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: userIsOnlineOffline ? Colors.green : null,
            borderRadius: BorderRadius.circular(100)),
      )
    ],
  );
}

// Launch url on web browser
Future openUrl({required String url}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    return await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication);
  } else {
    throw "Could not launch $url";
  }
}
