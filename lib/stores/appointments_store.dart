import 'package:mobx/mobx.dart';

part 'appointments_store.g.dart';

class AppointmentsStore = AppointmentsStoreBase with _$AppointmentsStore;

abstract class AppointmentsStoreBase with Store {
  
  _AppointmentsStore() {
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
  ObservableList<Map<dynamic, dynamic>> appointmentsDataList = ObservableList<Map<dynamic, dynamic>>();

  @observable
  Map<dynamic, dynamic> selectedAppointment = {};

  @action
  void setSelectedAppointment(Map<dynamic, dynamic> data) {
    selectedAppointment = data;
  }

  @action
  void addAppointmentToAppointmentsData(Map<dynamic, dynamic> data) {
    appointmentsDataList.add(data);
  }

  // @action
  // void removeAppointmentToAppointmentsData(Map<dynamic, dynamic> data) {
  //   doctorsDataList.remove(data);
  //   printLog(doctorsDataList);
  // }
  
  @action
  void clearAppointmentsData() {
    appointmentsDataList.clear();
  }

}