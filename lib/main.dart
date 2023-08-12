import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/views/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(388, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.blackColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
          home: child,
        );
      },
      child: HomeScreen(),
    );
  }
}
