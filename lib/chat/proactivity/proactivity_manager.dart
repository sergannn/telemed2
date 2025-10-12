import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ProactivityTrigger {
  final String name;
  final String reason;

  ProactivityTrigger(this.name, this.reason);

  Map<String, dynamic> toJson() => {
    'name': name,
    'reason': reason,
  };

  factory ProactivityTrigger.fromJson(Map<String, dynamic> json) {
    return ProactivityTrigger(
      json['name'] as String,
      json['reason'] as String,
    );
  }
}

class ProactivityManager {
  static final ProactivityManager _instance = ProactivityManager._internal();

  factory ProactivityManager() {
    return _instance;
  }

  ProactivityManager._internal();

  final _triggerController = BehaviorSubject<ProactivityTrigger>();

  void addTrigger(ProactivityTrigger trigger) {
    _triggerController.add(trigger);
  }

  Stream<ProactivityTrigger> get triggerStream => _triggerController.stream;
}