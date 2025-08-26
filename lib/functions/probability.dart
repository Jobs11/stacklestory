import 'dart:math';

class Probability {
  final List<double> _base;
  final List<int> _miss;
  final Random _rng;

  /// 미등장 1회당 곱해줄 배수(>1.0), 과도한 폭주 방지 캡
  final double missMultiplier; // 예: 1.10 => 10%씩 증가
  final double maxBoost; // 예: 3.0  => 최대 3배까지만

  Probability(
    List<double> base, {
    this.missMultiplier = 1.10,
    this.maxBoost = 3.0,
    Random? rng,
  }) : assert(base.isNotEmpty),
       _base = List<double>.from(base),
       _miss = List<int>.filled(base.length, 0),
       _rng = rng ?? Random();

  List<double> _currentWeights() {
    final w = <double>[];
    for (int i = 0; i < _base.length; i++) {
      final boosted = _base[i] * pow(missMultiplier, _miss[i]);
      w.add(min(boosted, _base[i] * maxBoost));
    }
    final sum = w.fold<double>(0, (a, b) => a + b);
    if (sum <= 0) return List<double>.filled(w.length, 1.0 / w.length);
    return w.map((e) => e / sum).toList();
  }

  int rollIndex() {
    final weights = _currentWeights();
    final r = _rng.nextDouble();
    double acc = 0;
    int chosen = weights.length - 1;
    for (int i = 0; i < weights.length; i++) {
      acc += weights[i];
      if (r <= acc) {
        chosen = i;
        break;
      }
    }
    for (int i = 0; i < _miss.length; i++) {
      _miss[i] = (i == chosen) ? 0 : (_miss[i] + 1);
    }
    return chosen;
  }

  List<double> peekProbabilities() => _currentWeights();
  void markAppeared(int index) {
    for (int i = 0; i < _miss.length; i++) {
      _miss[i] = (i == index) ? 0 : (_miss[i] + 1);
    }
  }

  void reset() {
    for (int i = 0; i < _miss.length; i++) {
      _miss[i] = 0;
    }
  }
}
