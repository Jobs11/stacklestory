import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacklestory/functions/datas.dart';
import 'dart:math' as math;

import 'package:stacklestory/icons/dragicons.dart';
import 'package:stacklestory/icons/dragmovepare.dart';

class Maingame extends StatefulWidget {
  const Maingame({super.key});

  @override
  State<Maingame> createState() => _MaingameState();
}

class _MaingameState extends State<Maingame> {
  int score = 12800;
  MonsterQueue mq = MonsterQueue(4);
  int stage = 6;

  @override
  void initState() {
    super.initState();
    mq = MonsterQueue(stage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 (맨 아래)
          Positioned.fill(
            child: Image.asset(
              backgroundsimg[Backgroundnum.bn],
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3.w),
                    borderRadius: BorderRadius.circular(20.r),
                    color: Color(0xFFFFFFFF),
                  ),
                  width: 180.w,
                  height: 50.h,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF000000),
                      borderRadius: BorderRadius.circular(20.r),
                    ),

                    child: Text(
                      score.toString(),
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0.h, 0.w, 0.h),
                      child: Stack(
                        children: [
                          // 1) 그라데이션 보더 레이어
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Colors.black, Colors.white],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds),
                            blendMode: BlendMode.srcATop, // 중요!
                            child: Container(
                              width: 140.w,
                              height: 90.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 6.w,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.transparent,
                              ),
                            ),
                          ),

                          // 2) 안쪽 흰 배경 레이어
                          Positioned.fill(
                            child: Padding(
                              padding: EdgeInsets.all(6.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  math.max(0, 20.r - 6.w),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFa6a6a6),
                                        Colors.white,
                                      ], // 시작, 끝 색상
                                      begin:
                                          Alignment.centerLeft, // 그라데이션 시작 위치
                                      end: Alignment.centerRight, // 끝 위치
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          15.w,
                                          5.h,
                                          15.w,
                                          5.h,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF000000),
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 4.w,
                                          ),
                                        ),
                                        height: 25.h,

                                        child: Text(
                                          'SKILL',
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 4.0.sp,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          15.w,
                                          5.h,
                                          15.w,
                                          5.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Image.asset(
                                                'assets/images/icons/머쉬맘 내려찍기.png',
                                                width: 30.w,
                                                height: 30.h,
                                              ),
                                            ),

                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Image.asset(
                                                'assets/images/icons/자쿰 흔들기.png',
                                                width: 30.w,
                                                height: 30.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 134.w,
                      height: 80.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/icons/양피지.png',
                            width: 134.w,
                            height: 80.h,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(35.w, 5.h, 35.w, 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                monsterByIndex(mq.queue[1]),

                                monsterByIndex(mq.queue[2]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                DragMovePair(
                  pumpkinAsset: 'assets/images/icons/집게.png',
                  overlayAsset: monsterData[mq.queue[0]]['name'],
                  iconSize: 120,
                  overlaySize: monsterData[mq.queue[0]]['size'],
                  overlayDy: 30,
                  padding: 10,
                  onTap: () {
                    mq.next();

                    setState(() {});
                  },
                ),

                // Container(
                //   color: Colors.transparent,
                //   height: 120,
                //   width: double.infinity,
                //   child: Dragicons(
                //     assetPath: 'assets/images/icons/집게.png',
                //     size: 120,
                //     padding: 10,
                //   ),
                // ),
                SizedBox(height: 10.h),
                Container(
                  margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0.h),
                  padding: EdgeInsets.fromLTRB(2.w, 16.h, 2.w, 12.h),
                  decoration: BoxDecoration(
                    color: Color(0x8CFFFFFF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  height: 500.h,
                  child: SingleChildScrollView(
                    child: Column(children: [getRandomMonster(7)]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
