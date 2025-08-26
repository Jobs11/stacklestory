import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> backgroundsimg = [
  "assets/images/backgrounds/spring.png",
  "assets/images/backgrounds/summer.png",
  "assets/images/backgrounds/fall.png",
  "assets/images/backgrounds/winter.png",
];

class Backgroundnum {
  static int bn = 2;
}

final List<Widget> monsterImages = [
  Image.asset(
    "assets/images/monsters/달수.png",
    width: 15.w,
    height: 15.h,
  ), // 1단계
  Image.asset(
    "assets/images/monsters/슬수.png",
    width: 30.w,
    height: 30.h,
  ), // 2단계
  Image.asset(
    "assets/images/monsters/주수.png",
    width: 45.w,
    height: 45.h,
  ), // 3단계
  Image.asset(
    "assets/images/monsters/리수.png",
    width: 60.w,
    height: 60.h,
  ), // 4단계
  Image.asset(
    "assets/images/monsters/루수.png",
    width: 75.w,
    height: 75.h,
  ), // 5단계
  Image.asset(
    "assets/images/monsters/주루수.png",
    width: 90.w,
    height: 90.h,
  ), // 6단계
  Image.asset(
    "assets/images/monsters/스수.png",
    width: 105.w,
    height: 105.h,
  ), // 7단계
];

final List<Widget> monsterUpgrade = [
  Image.asset("assets/images/monsters/달수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/슬수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/주수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/리수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/루수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/주루수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/스수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/월수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/예수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/핑수.png", width: 12.w, height: 12.h),
  Image.asset("assets/images/monsters/블수.png", width: 12.w, height: 12.h),
];

final List<double> threeStage = [
  0.28, // 1 달팽이
  0.22, // 2 슬라임
  0.18, // 3 주황버섯
];

final List<double> fourStage = [
  0.28, // 1 달팽이
  0.22, // 2 슬라임
  0.18, // 3 주황버섯
  0.14, // 4 리본돼지
];

final List<double> fiveStage = [
  0.28, // 1 달팽이
  0.22, // 2 슬라임
  0.18, // 3 주황버섯
  0.14, // 4 리본돼지
  0.09, // 5 루팡
];

final List<double> sixStage = [
  0.28, // 1 달팽이
  0.22, // 2 슬라임
  0.18, // 3 주황버섯
  0.14, // 4 리본돼지
  0.09, // 5 루팡
  0.06, // 6 주니어 루이넬
];

final List<double> sevenStage = [
  0.28, // 1 달팽이
  0.22, // 2 슬라임
  0.18, // 3 주황버섯
  0.14, // 4 리본돼지
  0.09, // 5 루팡
  0.06, // 6 주니어 루이넬
  0.03, // 7 스타픽시
];
