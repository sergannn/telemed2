// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PatientsStore on PatientsStoreBase, Store {
  late final _$patientsDataListAtom =
      Atom(name: 'PatientsStoreBase.patientsDataList', context: context);

  @override
  ObservableList<Map<dynamic, dynamic>> get patientsDataList {
    _$patientsDataListAtom.reportRead();
    return super.patientsDataList;
  }

  @override
  set patientsDataList(ObservableList<Map<dynamic, dynamic>> value) {
    _$patientsDataListAtom.reportWrite(value, super.patientsDataList, () {
      super.patientsDataList = value;
    });
  }

  late final _$selectedPatientAtom =
      Atom(name: 'PatientsStoreBase.selectedPatient', context: context);

  @override
  Map<dynamic, dynamic> get selectedPatient {
    _$selectedPatientAtom.reportRead();
    return super.selectedPatient;
  }

  @override
  set selectedPatient(Map<dynamic, dynamic> value) {
    _$selectedPatientAtom.reportWrite(value, super.selectedPatient, () {
      super.selectedPatient = value;
    });
  }

  late final _$PatientsStoreBaseActionController =
      ActionController(name: 'PatientsStoreBase', context: context);

  @override
  void setSelectedPatient(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$PatientsStoreBaseActionController.startAction(
        name: 'PatientsStoreBase.setSelectedPatient');
    try {
      return super.setSelectedPatient(data);
    } finally {
      _$PatientsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPatientToPatientsData(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$PatientsStoreBaseActionController.startAction(
        name: 'PatientsStoreBase.addPatientToPatientsData');
    try {
      return super.addPatientToPatientsData(data);
    } finally {
      _$PatientsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearPatientsData() {
    final _$actionInfo = _$PatientsStoreBaseActionController.startAction(
        name: 'PatientsStoreBase.clearPatientsData');
    try {
      return super.clearPatientsData();
    } finally {
      _$PatientsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
patientsDataList: ${patientsDataList},
selectedPatient: ${selectedPatient}
    ''';
  }
}
