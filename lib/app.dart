import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_scraping_task/product_details/presentation/cubit/product_cubit.dart';
import 'package:web_scraping_task/product_details/presentation/view/product_screen.dart';
import 'injector.dart' as di;
import 'config/themes/app_theme.dart';

class WebScrapingApp extends StatelessWidget {
  const WebScrapingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) => MaterialApp(
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          home: BlocProvider(
            create: (context) => di.sl<ProductCubit>(),
            child: ProductDetailsScreen(),
          )),
    );
  }
}
