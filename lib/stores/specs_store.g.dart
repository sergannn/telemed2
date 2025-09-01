// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specs_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SpecsStore on SpecsStoreBase, Store {
  late final _$specsDataListAtom =
      Atom(name: 'SpecsStoreBase.specsDataList', context: context);

  @override
  ObservableList<SpecialistModel> get specsDataList {
    _$specsDataListAtom.reportRead();
    return super.specsDataList;
  }

  @override
  set specsDataList(ObservableList<SpecialistModel> value) {
    _$specsDataListAtom.reportWrite(value, super.specsDataList, () {
      super.specsDataList = value;
    });
  }

  late final _$SpecsStoreBaseActionController =
      ActionController(name: 'SpecsStoreBase', context: context);

  @override
  void addSpecToSpecsData(dynamic data) {
    final _$actionInfo = _$SpecsStoreBaseActionController.startAction(
        name: 'SpecsStoreBase.addSpecToSpecsData');
    try {
      return super.addSpecToSpecsData(data);
    } finally {
      _$SpecsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearDoctorsData() {
    final _$actionInfo = _$SpecsStoreBaseActionController.startAction(
        name: 'SpecsStoreBase.clearDoctorsData');
    try {
      return super.clearDoctorsData();
    } finally {
      _$SpecsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
specsDataList: ${specsDataList}
    ''';
  }
}
