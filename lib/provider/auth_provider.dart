import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:blood_donor/screens/otp_screen.dart';
import 'package:blood_donor/model/user_model.dart';
import 'package:blood_donor/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFiretore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSign();
  }
  Future<bool> checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();

    return _isSignedIn;
  }

  String printuser() {
    return _firebaseAuth.currentUser.toString();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

//sign in with phone number
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          //throw Exception(error);
          // ShowSnackBar(context, error.toString());
          _isLoading = false;
          notifyListeners();
          ShowSnackBar(context, error.message.toString());
        },
        codeSent: ((verificationId, forceResendingToken) {
          _isLoading = false;

          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(vertificationId: verificationId),
            ),
          );
        }),
        codeAutoRetrievalTimeout: (vertifcationId) {},
      );
    } on FirebaseAuthException catch (e) {
      //ShowSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
      showMessageBox(context, e.message.toString());
    }
  }

//vertify otp

  void vertifyotp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSucces,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;
      if (user != null) {
        //carry out logic
        _uid = user.uid;
        onSucces();
      }

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  //database operations

  Future<bool> checkExtingUser() async {
    print(_uid);
    DocumentSnapshot snapshot =
        await _firebaseFiretore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFileToStorage("profilePic/$_uid", profilePic, context)
          .then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModel = userModel;

      // uploading to database
      await _firebaseFiretore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showMessageBox(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(
      String ref, File file, BuildContext context) async {
    try {
      UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseAuthException catch (e) {
      showMessageBox(context, e.message.toString());
    }
    return "";
  }

  Future getDataFromFirestore() async {
    await _firebaseFiretore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        name: snapshot['name'],
        email: snapshot['email'],
        createdAt: snapshot['createdAt'],
        adress: snapshot['adress'],
        bio: snapshot['bio'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
      );
      _uid = userModel.uid;
    });
  }

  // STORING DATA LOCALLY
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}
