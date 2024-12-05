import 'package:firebase_auth/firebase_auth.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/domain/entities/app_user.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/domain/entities/repos/auth_repo.dart';


class FirebaseAuthRepo implements AuthRepo{
  
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try{

      //atempt sign in
      UserCredential userCredential = await firebaseAuth
      .signInWithEmailAndPassword(email: email, password: password);
      
      //fecth user document from firestore
      DocumentSnapshot userDoc = await firebaseFirestore
      .collection('users')
      .doc(userCredential.user!.uid)
      .get();

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid, 
      email: email, 
      name: userDoc['name'],
      );

      //return user 
      return user;
    }
     // catch any errors..
    catch (e) {
      throw Exception('Login failed: $e');
    }
  }
   @override
  Future<AppUser?> registerWithEmailPassword(String name, String email, String password) async {
    try{

      //atempt sign up
      UserCredential userCredential = await firebaseAuth
      .createUserWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid, 
      email: email, 
      name: name,
      );

      //save user in firestore
      await firebaseFirestore
      .collection("users")
      .doc(user.uid)
      .set(user.toJson());

      //return user 
      return user;
    }
     // catch any errors..
    catch (e) {
      throw Exception('Login failed: $e');
    }
  }
  
  @override
  Future<void> logout()async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    //get current logged in user from Firebase
    final firebaseUser= firebaseAuth.currentUser;
// no user logged in..
    if (firebaseUser == null) {

      return null;
    }

    //fetch user document from firestore
    DocumentSnapshot userDoc = 
    await firebaseFirestore.collection("user").doc(firebaseUser.uid).get();

    // check if user doc exists
    if (!userDoc.exists){
      return null;
    }
    // user exists
    return AppUser(
      uid: firebaseUser.uid, 
      email: firebaseUser.email!, 
      name: userDoc['name'],
      );
  }
  }

