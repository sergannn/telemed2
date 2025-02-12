import 'dart:developer';

import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  UserStoreBase() {
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
      reaction((_) => userData, (_) {
        print("User data changed");
        // Perform any necessary actions when user data changes
      }),
      // reaction((_) => emptyValue, (_) {}),
    ];
  }

  @observable
  ObservableMap<dynamic, dynamic> userData = ObservableMap<dynamic, dynamic>();

  @action
  void setUserData(Map<dynamic, dynamic> data) {
    userData = ObservableMap<dynamic, dynamic>.of(data);
  }
}
