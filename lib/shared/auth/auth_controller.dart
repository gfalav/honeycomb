import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final uid = "".obs;

  final emailController = TextEditingController(text: 'gfalav@yahoo.com');
  final passwordController = TextEditingController(text: 'pppppp');

  @override
  void onInit() async {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        uid.value = "";
      } else if (user.emailVerified) {
        uid.value = user.uid;
      } else {
        uid.value = "";
      }
    });
    super.onInit();
  }

  Future<void> signUp() async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      await userCredential.user!.sendEmailVerification();
      await _auth.signOut();
      Get.snackbar(
        "Success",
        "Verification email sent",
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.primary,
        duration: Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "SignUp Error",
        e.message ?? "An unknown error occurred",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.error,
        duration: Duration(seconds: 5),
      );
    }
  }

  Future<void> signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.snackbar(
        "Success",
        "User Signed In",
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.primary,
        duration: Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "SignIn Error",
        e.message ?? "An unknown error occurred",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.error,
        duration: Duration(seconds: 5),
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.snackbar(
      "User Signed Out",
      "Goodbye!",
      backgroundColor: Get.theme.colorScheme.primaryContainer,
      colorText: Get.theme.colorScheme.primary,
      duration: Duration(seconds: 5),
    );
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      Get.snackbar(
        "Success",
        "Password reset email sent",
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.primary,
        duration: Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "An unknown error occurred",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.error,
        duration: Duration(seconds: 5),
      );
    }
  }

  Future<void> updatePassword() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(passwordController.text);
        Get.snackbar(
          "Success",
          "Password updated successfully",
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          colorText: Get.theme.colorScheme.primary,
          duration: Duration(seconds: 5),
        );
      } else {
        Get.snackbar(
          "Error",
          "No user is currently signed in",
          backgroundColor: Get.theme.colorScheme.errorContainer,
          colorText: Get.theme.colorScheme.error,
          duration: Duration(seconds: 5),
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "An unknown error occurred",
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.error,
        duration: Duration(seconds: 5),
      );
    }
  }
}
