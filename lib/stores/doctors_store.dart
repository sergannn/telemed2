import 'dart:developer';

import 'package:doctorq/utils/utility.dart';
import 'package:mobx/mobx.dart';

part 'doctors_store.g.dart';

class DoctorsStore = DoctorsStoreBase with _$DoctorsStore;

abstract class DoctorsStoreBase with Store {
  _DoctorsStore() {
    setupReactions();
  }

  late List<ReactionDisposer> _disposers;

  void dispose() {
    if (_disposers.isEmpty) return;
    for (final reactionDisposer in _disposers) {
      reactionDisposer();
    }
  }

  void setupReactions() {
    _disposers = [
      // reaction((_) => emptyValue, (_) {}),
    ];
  }

  @observable
  ObservableList<Map<dynamic, dynamic>> doctorsDataList =
      ObservableList<Map<dynamic, dynamic>>();

  @observable
  Map<dynamic, dynamic> selectedDoctor = {};

  @action
  void setSelectedDoctor(Map<dynamic, dynamic> data) {
    selectedDoctor = data;
  }

  @action
  void addDoctorToDoctorsData(Map<dynamic, dynamic> data) {
    doctorsDataList.add(data);
  }

  // @action
  // void removeDoctorFromDoctorsData(Map<dynamic, dynamic> data) {
  //   doctorsDataList.remove(data);
  //   printLog(doctorsDataList);
  // }

  @action
  void clearDoctorsData() {
    doctorsDataList.clear();
  }
}
