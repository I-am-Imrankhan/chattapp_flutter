import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as fb;

class AuthenticationProvider {
  var isLoading = true;
  var currentUser;
  
  final FirebaseAuth firebaseAuth;
  AuthenticationProvider(this.firebaseAuth, );

  Stream<User?> get authState =>
      firebaseAuth.idTokenChanges();

  void printUserState() {
    currentUser = firebaseAuth.currentUser;

    isLoading = false;
  }

  


  Future<String?> signUp({ email, password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn({email, password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
