import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_clean_architecture/core/utils/app_routers.dart';

import '../../../../global widgets/custom_indicator.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boardingPages = [
    OnBoardingModel(
      imageUrl: 'assets/images/image1.png',
      title: 'Buy',
      description: 'Shop from thousands of brands\n at throwaway prices.',
    ),
    OnBoardingModel(
      imageUrl: 'assets/images/image2.png',
      title: 'ONLINE CART',
      description:
          'Select and memorize your future pur-\n chases with smart online shopping cart.',
    ),
    OnBoardingModel(
      imageUrl: 'assets/images/image3.png',
      title: 'SALES AND GIFTS',
      description:
          'Holiday sales .Birthday gifts.\nVarious choice and categories.',
    ),
  ];

  PageController boardingController = PageController();

  void submit() async {
    AppRouters.goAndReplacement(context: context, route: LoginScreen.route);

    final pref = await SharedPreferences.getInstance();

    pref.setBool('isWatchOnBoard', true);
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height * 0.03, horizontal: width * 0.05),
          child: Stack(
            children: [
              PageView.builder(
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                itemCount: boardingPages.length,
                itemBuilder: (ctx, index) {
                  return buildOnBoardingItem(boardingPages[index], context);
                },
                onPageChanged: (newPage) => setState(
                  () => currentPage = newPage,
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.75),
                child: ElevatedButton(
                  onPressed: submit,
                  child: Text(
                    'Get Started',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, 0.85),
                child: CustomIndicator(
                  index: currentPage,
                  length: boardingPages.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(
    OnBoardingModel onBoardingModel, BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: constraints.maxHeight * 0.05),
        SizedBox(
          height: constraints.maxHeight * 0.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(360.r),
            child: Image(
              image: AssetImage(onBoardingModel.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.08, //0.15,
          child: Text(
            onBoardingModel.title,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 30.sp,
                color: const Color(0xffe85d04),
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.12,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: FittedBox(
              child: Text(
                onBoardingModel.description,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: 25.sp,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class OnBoardingModel {
  final String imageUrl;
  final String title;

  final String description;

  OnBoardingModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}
