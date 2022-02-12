

import 'package:animalmandi/views/screens/login_success/login_success_screen.dart';
import 'package:animalmandi/views/screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../models/user_model.dart' as model ;

class AuthController extends GetxController{
    static AuthController instance=Get.find();
     late Rx<User?> _user;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user=Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user,_setInitialScreen);
  }
  _setInitialScreen(User? user){
      if(user==null){
        Get.offAll(()=>SignInScreen.routeName);
      }else{
        Get.offAll(()=>LoginSuccessScreen.routeName);
      }
  }


  void RegisterUser(
    String email,
    String password,
    
  ) async {
    try {
      if (
          email.isNotEmpty &&
          password.isNotEmpty 
          ) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        model.User user = model.User(
            email: email,
            uid: cred.user!.uid,
           );
      fireStore.collection('users').doc(cred.user!.uid).set(user.toJson());
      }else{
        Get.snackbar("Error Creating account", 'Please enter all the fields');
      }
      
    } catch (e) {
      Get.snackbar("Error Creating account", e.toString());
    }

  }
  void loginUser(String email,String password)async{
    try{if(
    email.isNotEmpty &&
        password.isNotEmpty ){
       await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
       print('log Success');
    }else{
      Get.snackbar("Error Loggin In", 'Please enter all the fields');


    }

    }catch(e){
      Get.snackbar("Error Logging In", e.toString());

    }
  }

}