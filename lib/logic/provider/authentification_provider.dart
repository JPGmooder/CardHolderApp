import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationProvider {
 static Future<GoogleSignInAccount?> signIn() async {
    SharedPreferences dataStore = await SharedPreferences.getInstance();
    if (dataStore.containsKey("User")) {
      return (await GoogleSignIn().signInSilently());
    } else {
      return (await GoogleSignIn().signIn());
    }
  }

  static Future<GoogleSignInAccount?> logOut() async {
   await GoogleSignIn().signOut();
    }
  }

