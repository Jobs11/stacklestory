import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> backgroundsimg = [
  "assets/images/backgrounds/spring.png",
  "assets/images/backgrounds/summer.png",
  "assets/images/backgrounds/fall.png",
  "assets/images/backgrounds/winter.png",
];

List<String> upgradeimg = [
  "assets/images/upgrades/whitearrow.png",
  "assets/images/upgrades/whitearrow.png",
  "assets/images/upgrades/whitearrow.png",
  "assets/images/upgrades/whitearrow.png",
];

class Backgroundnum {
  static int bn = 0;
}

final List<Widget> monsterUpgrade = [
  Image.asset("assets/images/monsters/달수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/슬수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/주수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/리수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/루수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/주루수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/스수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/월수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/예수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/핑수.png", width: 20.w, height: 20.h),
  Image.asset("assets/images/monsters/블수.png", width: 20.w, height: 20.h),
];

// 단계별 몬스터 정의 (파일명, 크기)
final List<Map<String, dynamic>> monsterData = [
  {"name": "달수", "size": 15.0},
  {"name": "슬수", "size": 30.0},
  {"name": "주수", "size": 45.0},
  {"name": "리수", "size": 60.0},
  {"name": "루수", "size": 75.0},
  {"name": "주루수", "size": 90.0},
  {"name": "스수", "size": 105.0},
  {"name": "월수", "size": 120.0},
  {"name": "예수", "size": 135.0},
  {"name": "핑수", "size": 150.0},
  {"name": "블수", "size": 165.0},
  // 이후 월묘, 예티, 핑크빈, 블랙빈도 추가 가능
];

// 특정 스테이지까지 몬스터 리스트 생성
List<Widget> buildStage(int stage) {
  return List.generate(stage, (i) {
    final data = monsterData[i];
    return Image.asset(
      "assets/images/monsters/${data['name']}.png",
      width: (data['size'] as double).w,
      height: (data['size'] as double).h,
    );
  });
}

// 동일 확률로 하나 뽑기
Widget getRandomMonster(int stage) {
  final rand = Random();
  int index = rand.nextInt(stage); // 0 ~ stage-1
  final data = monsterData[index];
  return Image.asset(
    "assets/images/monsters/${data['name']}.png",
    width: (data['size'] as double).w,
    height: (data['size'] as double).h,
  );
}

final Random _rng = Random();
int drawIndex(int stage) {
  final s = stage.clamp(1, monsterData.length);
  return _rng.nextInt(s); // 0 ~ s-1
}

// 인덱스로 실제 위젯 만들기
Widget monsterByIndex(int index) {
  final data = monsterData[index];
  return Image.asset(
    "assets/images/monsters/${data['name']}.png",
    width: 25.w,
    height: 25.h,
  );
}

class MonsterQueue with ChangeNotifier {
  final int stage; // 동일확률 뽑기 범위 (1..stage)
  late List<int> queue; // 길이 3: [다음, 그다음, 다다음]

  MonsterQueue(this.stage) {
    queue = [drawIndex(stage), drawIndex(stage), drawIndex(stage)];
  }

  /// 한 턴 진행:
  /// [0] 사용 → [1]이 앞으로, [2]가 앞으로, [2]는 새 랜덤으로 채움
  /// 반환: 방금 소비된 인덱스
  int next() {
    final used = queue[0];
    queue[0] = queue[1];
    queue[1] = queue[2];
    queue[2] = drawIndex(stage);
    notifyListeners();
    return used;
  }

  /// (옵션) n턴 한 번에 진행
  void skip(int n) {
    for (int i = 0; i < n; i++) {
      next();
    }
  }
}

// class MonsterQueue with ChangeNotifier {
//   final int stage; // 현재 최고 스테이지 (동일확률 뽑기 범위)
//   late List<int> queue; // 길이 2, 인덱스만 저장

//   MonsterQueue(this.stage) {
//     queue = [drawIndex(stage), drawIndex(stage)];
//   }

//   /// 현재 턴을 소비하고 다음으로 진행
//   /// 반환값: 방금 소비된(사용된) 인덱스
//   int next() {
//     final used = queue[0];
//     queue[0] = queue[1];
//     queue[1] = drawIndex(stage);
//     notifyListeners();
//     return used;
//   }
// }
