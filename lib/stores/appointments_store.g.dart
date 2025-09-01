// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppointmentsStore on AppointmentsStoreBase, Store {
  late final _$appointmentsDataListAtom = Atom(
      name: 'AppointmentsStoreBase.appointmentsDataList', context: context);

  @override
  ObservableList<Map<dynamic, dynamic>> get appointmentsDataList {
    _$appointmentsDataListAtom.reportRead();
    return super.appointmentsDataList;
  }

  @override
  set appointmentsDataList(ObservableList<Map<dynamic, dynamic>> value) {
    _$appointmentsDataListAtom.reportWrite(value, super.appointmentsDataList,
        () {
      super.appointmentsDataList = value;
    });
  }

  late final _$selectedAppointmentAtom =
      Atom(name: 'AppointmentsStoreBase.selectedAppointment', context: context);

  @override
  Map<dynamic, dynamic> get selectedAppointment {
    _$selectedAppointmentAtom.reportRead();
    return super.selectedAppointment;
  }

  @override
  set selectedAppointment(Map<dynamic, dynamic> value) {
    _$selectedAppointmentAtom.reportWrite(value, super.selectedAppointment, () {
      super.selectedAppointment = value;
    });
  }

  late final _$AppointmentsStoreBaseActionController =
      ActionController(name: 'AppointmentsStoreBase', context: context);

  @override
  void setSelectedAppointment(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$AppointmentsStoreBaseActionController.startAction(
        name: 'AppointmentsStoreBase.setSelectedAppointment');
    try {
      return super.setSelectedAppointment(data);
    } finally {
      _$AppointmentsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAppointmentToAppointmentsData(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$AppointmentsStoreBaseActionController.startAction(
        name: 'AppointmentsStoreBase.addAppointmentToAppointmentsData');
    try {
      return super.addAppointmentToAppointmentsData(data);
    } finally {
      _$AppointmentsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAppointmentsData() {
    final _$actionInfo = _$AppointmentsStoreBaseActionController.startAction(
        name: 'AppointmentsStoreBase.clearAppointmentsData');
    try {
      return super.clearAppointmentsData();
    } finally {
      _$AppointmentsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appointmentsDataList: ${appointmentsDataList},
selectedAppointment: ${selectedAppointment}
    ''';
  }
}
