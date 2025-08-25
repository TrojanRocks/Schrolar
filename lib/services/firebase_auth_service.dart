import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final fb.FirebaseAuth _auth;
  final GoogleSignIn _google;
  FirebaseAuthService({fb.FirebaseAuth? auth, GoogleSignIn? google})
      : _auth = auth ?? fb.FirebaseAuth.instance,
        _google = google ?? GoogleSignIn();

  @override
  Future<String?> getCurrentUserId() async {
    return _auth.currentUser?.uid;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    try {
      await _google.signOut();
    } catch (_) {}
  }

  @override
  Future<String> signUpWithEmail(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return cred.user!.uid;
  }

  @override
  Future<String> signInWithEmail(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred.user!.uid;
  }

  @override
  Future<String> signInWithGoogle() async {
    final account = await _google.signIn();
    final auth = await account!.authentication;
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    final userCred = await _auth.signInWithCredential(credential);
    return userCred.user!.uid;
  }
}


