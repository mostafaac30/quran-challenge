import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_challenge/models/user_data.dart';
import 'pages/../states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool isLogin = false;

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(LoginWithEmailSuccessState(uid: userCredential.user!.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(LoginErrorState());
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(LoginErrorState());
      }
    } catch (e) {
      print(e);
      emit(LoginErrorState());
    }
  }

  Future createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignUpWithEmailLoadingState());
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignUpWithEmailSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(SignUpWithEmailErrorState());
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(SignUpWithEmailErrorState());
      }
    } catch (e) {
      print(e);
      emit(SignUpWithEmailErrorState());
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    // await FacebookAuth.instance.logOut();
    isLogin = false;
    emit(LogOutState());
  }

  bool isLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isLogin = true;
      emit(LoginWithEmailSuccessState(uid: user.uid));
      return true;
    } else {
      isLogin = false;
      emit(LogOutState());
      return false;
    }
  }

//
}
