import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'Screens/GetStartedScreen/GetStartedPage.dart';
import 'Screens/HomeScreen/HomePage.dart';
import 'Screens/LoginScreen/LoginPage.dart';
import 'Screens/SplashScreen/SplashPage.dart';
import 'Utils/ConstHelper.dart';
import 'Utils/SharedPrefHelper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCc5j805URN9GPfM_yNZUH9X7EBuJBkdws',
      appId: 'singleclick-13280',
      messagingSenderId: '126017152083',
      projectId: 'singleclick-13280',
      storageBucket: 'singleclick-13280.firebasestorage.app',
    ),
  );
  await SharedPrefHelper.sharedPrefHelper.initSharedPref();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  configLoading();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ASVT Bangalore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      navigatorKey: ConstHelper.navigatorKey,
      builder: EasyLoading.init(),
      routes: {
        '/' : (p0) => const SplashPage(),
        'getStarted' : (p0) => const GetStartedPage(),
        'login' : (p0) => const LoginPage(),
        'home' : (p0) => const HomePage(),
      },
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}
