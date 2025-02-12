import 'package:mobx/mobx.dart';

part 'doctor_sessions_store.g.dart';

class DoctorSessionsStore = DoctorSessionsStoreBase with _$DoctorSessionsStore;

abstract class DoctorSessionsStoreBase with Store {
  
  _DoctorSessionsStore() {
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
  ObservableList<Map<dynamic, dynamic>> doctorSessionsDataList = ObservableList<Map<dynamic, dynamic>>();

  @observable
  Map<dynamic, dynamic> selectedDoctorSession = {};

  @action
  void setSelectedDoctorSession(Map<dynamic, dynamic> data) {
    selectedDoctorSession = data;
  }

  @action
  void addDoctorSessionToDoctorSessionsData(Map<dynamic, dynamic> data) {
    doctorSessionsDataList.add(data);
  }

  @action
  void clearDoctorSessionsData() {
    doctorSessionsDataList.clear();
  }
  
}