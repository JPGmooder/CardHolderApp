
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthentificationEvent {}

class Authentification_SignIn_Via_Google implements AuthentificationEvent {}

class Authentification_LogIn_Via_Google implements AuthentificationEvent {
  AuthCredential credentialToLog;
  Authentification_LogIn_Via_Google(this.credentialToLog);
}

class Authentification_LogOut_Via_Google implements AuthentificationEvent {

}
