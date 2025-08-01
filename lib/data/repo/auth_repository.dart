import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entity/user.dart' as app_user;


class AuthRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<app_user.User?> signIn(String email, String password) async{
    try{
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password
      );

      if(userCredential.user != null){
        final userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if(userDoc.exists){
          return app_user.User.fromJson(userDoc.data()!, userCredential.user!.uid);
        }
      }
      return null;
    }catch(e){
      throw ("Username or password is incorrect, please try again...");
    }
  }

  Future<app_user.User?> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      if (userCredential.user != null) {
        final user = app_user.User(
            uid: userCredential.user!.uid,
            email: email,
            displayName: email.split('@')[0],
            role: "user",
            createdAt: DateTime.now()
        );

        await _firestore
            .collection("users")
            .doc(user.uid)
            .set(user.toJson());

        return user;
      }
      return null;
    } catch (e) {
      throw Exception("Failed sign up: $e");
    }
  }

  Future<void> signOut() async{
    try{
      await _auth.signOut();
    }catch(e){
      throw Exception("Failed sign out: $e");
    }
  }

  Future<app_user.User?> getCurrentUser() async{
    try{
      final firebaseUser = _auth.currentUser;
      if(firebaseUser != null){
        final userDoc = await _firestore
            .collection("users")
            .doc(firebaseUser.uid)
            .get();

        if(userDoc.exists){
          return app_user.User.fromJson(userDoc.data()!, firebaseUser.uid);
        }
      }
      return null;
    }catch(e){
      throw Exception("Error getting current user : $e");
    }
  }

  Future<void> resetPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      throw Exception("Password reset failed : $e");
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try{
      final user = _auth.currentUser;
      if(user != null){
        await user.updatePassword(newPassword);
      }
    }catch(e){
      throw Exception("Password update failed : $e");
    }
  }

  Future<void> deleteUser() async{
    try{
      final user = _auth.currentUser;
      if(user != null){
        await _firestore
            .collection("users")
            .doc(user.uid)
            .delete();

        await user.delete();
      }
    }catch(e){
      throw Exception("User deletion failed : $e");
    }
  }
  String getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Kullanıcı bulunamadı';
      case 'wrong-password':
        return 'Yanlış şifre';
      case 'email-already-in-use':
        return 'Bu email zaten kullanımda';
      case 'weak-password':
        return 'Şifre çok zayıf';
      case 'invalid-email':
        return 'Geçersiz email adresi';
      case 'user-disabled':
        return 'Kullanıcı hesabı devre dışı';
      case 'too-many-requests':
        return 'Çok fazla deneme yapıldı, lütfen bekleyin';
      default:
        return 'Bir hata oluştu: ${e.message}';
    }
  }
}