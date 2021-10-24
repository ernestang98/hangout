import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_ui_kit/DatabaseManager/DatabaseManager.dart';

class AuthenticationService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

//  registration with Email and Password
Future createNewUser(String username, String email, String password) async {
  try{
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    DatabaseManager().updateUserData(user.uid, username, email);

    return user;

  } catch(e){
    print(e.toString());
  }
}


// sign with email and password
Future loginUser(String email, String password) async {
  try{
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
  } catch (e) {
    print(e.toString());
  }
}

// get current user
String getCurrentUser() {
  try {
    return _auth.currentUser.uid;
  } on FirebaseAuthException {
    return null;
  }
}

// signout
Future signOut() async {
  try {
    await _auth.signOut();
    return "Signed out";
  } on FirebaseAuthException catch(e) {
    return e.message;
  }
}
}