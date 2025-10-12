import 'dart:developer';

import 'package:doctorq/data_files/specialist_list.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:mobx/mobx.dart';

part 'specs_store.g.dart';

class SpecsStore = SpecsStoreBase with _$SpecsStore;

abstract class SpecsStoreBase with Store {
  _SpecsStore() {
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
  ObservableList<SpecialistModel> specsDataList =
      ObservableList<SpecialistModel>();

  @action
  void addSpecToSpecsData(dynamic data) {
    specsDataList.add(data);
  }

  @action
  void clearDoctorsData() {
    specsDataList.clear();
  }
}
