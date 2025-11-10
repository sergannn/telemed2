// Обертка с условным импортом для DailyApp
// На мобильных платформах использует реальный DailyApp
// На веб использует заглушку
export 'main_stub.dart' if (dart.library.io) 'main.dart' show DailyApp, DailyCallMode;

