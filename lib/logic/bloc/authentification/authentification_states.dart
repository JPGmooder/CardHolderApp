import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/user_model.dart' as mainUser;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthentificationState {}

class AuthentificationInitialState implements AuthentificationState {
  CollectionReference usersCollection;
  AuthentificationInitialState(this.usersCollection);
}

class AuthentificationLoadingState implements AuthentificationState {}

class Authentification_LogedIn_Via_Google implements AuthentificationState {
  mainUser.User loggedUser;
  Authentification_LogedIn_Via_Google(this.loggedUser) {
    SharedPreferences.getInstance()
        .then((value) => value.setString("User", loggedUser.toJson()));
  }
}

class Authentification_LogedOut_Via_Google implements AuthentificationState {
  Authentification_LogedOut_Via_Google() {
    SharedPreferences.getInstance().then((value) => value.remove("User"));
  }
}
