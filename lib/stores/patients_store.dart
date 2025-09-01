import 'package:mobx/mobx.dart';

part 'patients_store.g.dart';

class PatientsStore = PatientsStoreBase with _$PatientsStore;

abstract class PatientsStoreBase with Store {
  _PatientsStore() {
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
  ObservableList<Map<dynamic, dynamic>> patientsDataList =
      ObservableList<Map<dynamic, dynamic>>();

  @observable
  Map<dynamic, dynamic> selectedPatient = {};

  @action
  void setSelectedPatient(Map<dynamic, dynamic> data) {
    selectedPatient = data;
  }

  @action
  void addPatientToPatientsData(Map<dynamic, dynamic> data) {
    patientsDataList.add(data);
  }

  @action
  void clearPatientsData() {
    patientsDataList.clear();
  }
}
