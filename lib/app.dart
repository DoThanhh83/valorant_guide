import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valoratn_gui/constants/app_colors.dart';
import 'package:valoratn_gui/screens/custom_error_screen.dart';
import 'package:valoratn_gui/screens/error_screen.dart';
import 'package:valoratn_gui/screens/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return kDebugMode
              ? CustomErrorScreen(errorDetails: errorDetails)
              : ErrorScreen(
                  errorDetails: errorDetails,
                  isNetworkError: false,
                );
        };
        return widget!;
      },
      child: MaterialApp(
        scrollBehavior: AppScrollBehavior(),
        // title: Platform.isAndroid ? 'Guide for Valo' : 'Handbook for Valorant',
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
        theme: AppTheme().valoTheme,
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
