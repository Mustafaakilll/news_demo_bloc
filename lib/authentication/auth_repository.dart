import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    try {
      _auth.signOut();
    } catch (e) {
      throw Exception('Hata $e');
    }
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Kullanici Bulunamadi');
      } else if (e.code == 'wrong-password') {
        throw Exception('Sifre Yanlis');
      }
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final _user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Zayif Parola');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Eposta Kullanimda');
      }
    } catch (err) {
      throw Exception('Hata $err');
    }
  }

  Future<User> signInWithGoogle() async {
    final googleUser = (await GoogleSignIn().signIn())!;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ) as GoogleAuthCredential;
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user!;

    return user;
  }
}
