import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn(
    clientId: "1065041387667-9s3piggc339ttudh5hrnsscclk1p66qh.apps.googleusercontent.com",
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );


  static Future<GoogleSignInAccount?> Login() => _googleSignIn.signInSilently();
  static Future<GoogleSignInAccount?>SignOut() => _googleSignIn.signOut();
}