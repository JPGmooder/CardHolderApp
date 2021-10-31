import '../../data/models/user_model.dart';
import '../provider/authentification_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';

class AuthentificationRepository {
  static Future<User?> loginUser() async {
    var userToConvert = await AuthentificationProvider.signIn();
    if (userToConvert == null) {
      return null;
    } else {
      var userToConvert = await AuthentificationProvider.signIn();
      var usersCredentials = await userToConvert!.authentication;
      await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: usersCredentials.idToken,
              accessToken: usersCredentials.accessToken));
      return User.fromGoogleSignInAccount(userToConvert);
    }
  }

  static Future logOut() async {
   await GoogleSignIn().signOut();
  }
}
