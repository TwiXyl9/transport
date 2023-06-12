import 'package:google_sign_in/google_sign_in.dart';
import 'package:transport/config/secrets.dart';

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn(
    clientId: Secrets.CLIENT_ID,
    scopes: <String>[
      'email',
    ],
  );


  static Future<GoogleSignInAccount?> Login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> SignOut() => _googleSignIn.signOut();
}