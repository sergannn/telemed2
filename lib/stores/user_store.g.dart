// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$userDataAtom =
      Atom(name: 'UserStoreBase.userData', context: context);

  @override
  ObservableMap<dynamic, dynamic> get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(ObservableMap<dynamic, dynamic> value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  late final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase', context: context);

  @override
  void setUserData(Map<dynamic, dynamic> data) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setUserData');
    try {
      return super.setUserData(data);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userData: ${userData}
    ''';
  }
}
