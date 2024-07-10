import 'package:divinity/FireBase/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Paths/imports.dart';



class Auth {



static void signUp(loader,_auth,emailController, passwordController,firestoreRef,PhoneNo,nameController,context) {
  _auth
      .createUserWithEmailAndPassword(
      email: emailController.text, password: passwordController.text)
      .then((val) {
    print(val);
    FireStore.userdata(firestoreRef,val,PhoneNo,emailController,nameController);

    print('user created');
    loader =false;
    ErrorMassage.errormassage(context, 'SignUp Successful ');
    NavigateToReplace(context, NavigationbarScreen());
  }).onError((error, stackTrace) {
    loader =false;
    ErrorMassage.errormassage(context, error.toString());
  });
}


// LogIn Function

static login(loader, emailController, passwordController, context, _auth,){
  _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((_){
    ErrorMassage.errormassage(context, 'LogIn Successful');
    NavigateTo(context, NavigationbarScreen());
    loader =false;
  }).onError((error, StackTrace){
    loader =false;
    ErrorMassage.errormassage(context, error.toString());

  });
}

// LogOut Function

static logOut(loader, context, _auth){
  _auth.signOut().then((val){
    NavigateToReplace(context, LogInScreen());
    loader =false;
    ErrorMassage.errormassage(context, 'LogedOut Successfully');
  }).onError((error,stackTrace){
    loader =false;
    ErrorMassage.errormassage(context, error.toString());

  });

}


static forget(loader,emailController, _bottom, context, _auth){
  _auth.sendPasswordResetEmail(email: emailController.text).then((_){
    loader =false;
    _bottom();
  }).onError((error,stackTrace){
    loader =false;
    ErrorMassage.errormassage(context, error);
  });

}

}





