import 'package:doctorq/stores/appointments_store.dart';
import 'package:doctorq/stores/doctor_sessions_store.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/stores/specs_store.dart';
import 'package:get_it/get_it.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

void initStores() {
  getIt.registerLazySingleton<UserStore>(() => UserStore());
  getIt.registerLazySingleton<DoctorsStore>(() => DoctorsStore());
  getIt.registerLazySingleton<AppointmentsStore>(() => AppointmentsStore());
  getIt.registerLazySingleton<DoctorSessionsStore>(() => DoctorSessionsStore());
  getIt.registerLazySingleton<SpecsStore>(() => SpecsStore());
}
