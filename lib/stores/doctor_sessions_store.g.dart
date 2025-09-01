// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_sessions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DoctorSessionsStore on DoctorSessionsStoreBase, Store {
  late final _$doctorSessionsDataListAtom = Atom(
      name: 'DoctorSessionsStoreBase.doctorSessionsDataList', context: context);

  @override
  ObservableList<Map<dynamic, dynamic>> get doctorSessionsDataList {
    _$doctorSessionsDataListAtom.reportRead();
    return super.doctorSessionsDataList;
  }

  @override
  set doctorSessionsDataList(ObservableList<Map<dynamic, dynamic>> value) {
    _$doctorSessionsDataListAtom
        .reportWrite(value, super.doctorSessionsDataList, () {
      super.doctorSessionsDataList = value;
    });
  }

  late final _$selectedDoctorSessionAtom = Atom(
      name: 'DoctorSessionsStoreBase.selectedDoctorSession', context: context);

  @override
  Map<dynamic, dynamic> get selectedDoctorSession {
    _$selectedDoctorSessionAtom.reportRead();
    return super.selectedDoctorSession;
  }

  @override
  set selectedDoctorSession(Map<dynamic, dynamic> value) {
    _$selectedDoctorSessionAtom.reportWrite(value, super.selectedDoctorSession,
        () {
      super.selectedDoctorSession = value;
    });
  }

  late final _$DoctorSessionsStoreBaseActionController =
      ActionController(name: 'DoctorSessionsStoreBase', context: context);

  @override
  void setSelectedDoctorSession(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$DoctorSessionsStoreBaseActionController.startAction(
        name: 'DoctorSessionsStoreBase.setSelectedDoctorSession');
    try {
      return super.setSelectedDoctorSession(data);
    } finally {
      _$DoctorSessionsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDoctorSessionToDoctorSessionsData(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$DoctorSessionsStoreBaseActionController.startAction(
        name: 'DoctorSessionsStoreBase.addDoctorSessionToDoctorSessionsData');
    try {
      return super.addDoctorSessionToDoctorSessionsData(data);
    } finally {
      _$DoctorSessionsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearDoctorSessionsData() {
    final _$actionInfo = _$DoctorSessionsStoreBaseActionController.startAction(
        name: 'DoctorSessionsStoreBase.clearDoctorSessionsData');
    try {
      return super.clearDoctorSessionsData();
    } finally {
      _$DoctorSessionsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
doctorSessionsDataList: ${doctorSessionsDataList},
selectedDoctorSession: ${selectedDoctorSession}
    ''';
  }
}
