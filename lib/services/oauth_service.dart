import 'package:google_sign_in/google_sign_in.dart';
import 'package:transport/config/secrets.dart';

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn(
    clientId: Secrets.CLIENT_ID,
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  static Future<GoogleSignInAccount?> Login() => _googleSignIn.signInSilently();
  static Future<GoogleSignInAccount?>SignOut() => _googleSignIn.signOut();
}