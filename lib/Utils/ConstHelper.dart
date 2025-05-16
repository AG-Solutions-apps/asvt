import 'dart:async';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';

import '../Screens/HomeScreen/carousel_image/sarousel_image.dart';

class ConstHelper {
  ConstHelper._();

  static ConstHelper constHelper = ConstHelper._();
  static final navigatorKey = GlobalKey<NavigatorState>();

  static TextStyle appBarTextStyle = TextStyle(
    color: ConstHelper.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color greyColor = Colors.grey;
  static Color orangeColor = const Color(0xFFF55C47);
  static Color orangeDarkColor = const Color(0xFFBD483C);
  static Color cementColor = const Color(0xFFA7AEB5);
  static Color darkRedColor = const Color(0xFF820815);
  static Color lightBlackColor = const Color(0xFF3A3838);

  static String pleaseWaitMsg = "Please wait...";
  static String internetMsg = "Please check your internet";
  static String somethingErrorMsg =
      "Sorry, Something has error\nPlease try again later...";
  static String nameNotAvailableMsg = "Name not available";
  static String fatherNameNotAvailableMsg = "Father name not available";
  static String emailNotAvailableMsg = "Email not available";
  static String naMsg = "N/A";
  static String yesMsg = "Yes";
  static String noMsg = "No";
  static String mobileNoNotAvailableMsg = "Mobile number not available";
  static String userImagesPath =
      "https://agstask.online/public/app_images/user_images/";
  static String profileImagePath =
      "https://agstask.online/public/app_images/user_images/no_profile.png";
  static String dataUpdatedSuccessfullyMsg = 'Data Updated Successfully';
  static String dataSubmittedSuccessfullyMsg = 'Data Submitted Successfully';
  static String dataDeletedSuccessfullyMsg = 'Data Deleted Successfully';
  static String enquireCloseSuccessfullyMsg = 'Enquire Close Successfully';
  static String somethingWantWrongMsg =
      'Sorry, Something want wrong\nPlease try again later...';

  /// Internet Connection Checking

  static Future<bool> checkInternet() async {
    try {
      var connectivityResultList = await Connectivity().checkConnectivity();
      return connectivityResultList
          .where((connectivityResult) =>
              (connectivityResult == ConnectivityResult.mobile ||
                  connectivityResult == ConnectivityResult.wifi))
          .toList()
          .isNotEmpty;
    } catch (error) {
      return false;
    }
  }

  static Future<DateTime> getCurrentDateTime() async {
    try {
      bool internetAvailable = await checkInternet();
      return internetAvailable ? await NTP.now() : DateTime.now();
    } catch (error) {
      return DateTime.now();
    }
  }

  static FilteringTextInputFormatter spaceNotAllowFilter =
      FilteringTextInputFormatter.deny(RegExp(r'\s'));
  static ImageFilter filter = ImageFilter.blur(sigmaX: 3, sigmaY: 3);

  static void errorDialog({
    required String text,
    required int seconds,
  }) {
    AwesomeDialog(
      context: navigatorKey.currentContext!,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      desc: text,
      btnOkOnPress: () {},
      autoHide: Duration(
        seconds: seconds,
      ),
      btnOkText: 'Close',
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
      // customHeader: Container(
      //   width: Get.width/6,
      //   height: Get.width/6,
      //   decoration: const BoxDecoration(
      //     color: Colors.red,
      //     shape: BoxShape.circle,
      //   ),
      //   alignment: Alignment.center,
      //   child: Icon(Icons.cancel,color: whiteColor,),
      // )
    ).show();
  }

  static void successDialog({
    required String text,
    required int seconds,
  }) {
    AwesomeDialog(
      context: navigatorKey.currentContext!,
      dialogType: DialogType.success,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      desc: text,
      autoHide: Duration(
        seconds: seconds,
      ),
      btnOkOnPress: () {},
      btnOkText: 'Close',
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green,
    ).show();
  }

  bool validateEmail({required String email}) {
    final emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<String> pickImage({required ImageSource source}) async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? xFile = await picker.pickImage(source: source);
      return xFile == null ? "" : xFile.path;
    } catch (error) {
      //////print("ERROR : $error");
      return "";
    }
  }

  void areYouSureWantAlertDialog({
    required String title,
    required String description,
    required void Function() onPressed,
  }) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return BackdropFilter(
          filter: filter,
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ConstHelper.orangeDarkColor,
                          fontSize: Get.width * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ConstHelper.blackColor,
                    fontSize: Get.width * 0.045,
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: orangeColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: orangeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showNetworkImageInDialog({
    required List<String> imgPath,
  }) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(
            horizontal: Get.width / 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
              height: Get.height / 2.3,
              width: Get.width / 1.2,
              child: SingleImageCarousel(
                imageUrls: imgPath,
              ) /*CachedNetworkImage(
              imageUrl: imgPath.trim().isEmpty
                  ? ConstHelper.profileImagePath
                  : '${ConstHelper.userImagesPath}$imgPath',
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: ConstHelper.orangeColor,
              )),
              errorWidget: (context, url, error) => Container(
                color: ConstHelper.whiteColor,
                child: Image.asset(
                  'assets/image/imageNotFound.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),*/
              ),
        );
      },
    );
  }
}
