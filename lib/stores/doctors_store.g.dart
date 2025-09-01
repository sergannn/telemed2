// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DoctorsStore on DoctorsStoreBase, Store {
  late final _$doctorsDataListAtom =
      Atom(name: 'DoctorsStoreBase.doctorsDataList', context: context);

  @override
  ObservableList<Map<dynamic, dynamic>> get doctorsDataList {
    _$doctorsDataListAtom.reportRead();
    return super.doctorsDataList;
  }

  @override
  set doctorsDataList(ObservableList<Map<dynamic, dynamic>> value) {
    _$doctorsDataListAtom.reportWrite(value, super.doctorsDataList, () {
      super.doctorsDataList = value;
    });
  }

  late final _$selectedDoctorAtom =
      Atom(name: 'DoctorsStoreBase.selectedDoctor', context: context);

  @override
  Map<dynamic, dynamic> get selectedDoctor {
    _$selectedDoctorAtom.reportRead();
    return super.selectedDoctor;
  }

  @override
  set selectedDoctor(Map<dynamic, dynamic> value) {
    _$selectedDoctorAtom.reportWrite(value, super.selectedDoctor, () {
      super.selectedDoctor = value;
    });
  }

  late final _$DoctorsStoreBaseActionController =
      ActionController(name: 'DoctorsStoreBase', context: context);

  @override
  void setSelectedDoctor(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$DoctorsStoreBaseActionController.startAction(
        name: 'DoctorsStoreBase.setSelectedDoctor');
    try {
      return super.setSelectedDoctor(data);
    } finally {
      _$DoctorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDoctorToDoctorsData(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$DoctorsStoreBaseActionController.startAction(
        name: 'DoctorsStoreBase.addDoctorToDoctorsData');
    try {
      return super.addDoctorToDoctorsData(data);
    } finally {
      _$DoctorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearDoctorsData() {
    final _$actionInfo = _$DoctorsStoreBaseActionController.startAction(
        name: 'DoctorsStoreBase.clearDoctorsData');
    try {
      return super.clearDoctorsData();
    } finally {
      _$DoctorsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
doctorsDataList: ${doctorsDataList},
selectedDoctor: ${selectedDoctor}
    ''';
  }
}
