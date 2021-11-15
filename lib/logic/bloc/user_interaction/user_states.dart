import 'package:card_holder_app_with_kistik_love/data/models/user_model.dart';

abstract class UserStates {}

class UserLoadedState implements UserStates {
  final User user;
  UserLoadedState(this.user);
}

class UserLoadingState implements UserStates {}

class UserChangedAvaState implements UserStates {
  final String pathToAva;
  UserChangedAvaState(this.pathToAva);
}
