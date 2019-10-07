import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_flutter/src/bloc/blocProvider.dart';

class MainBloc extends BlocBase {
  //-------------------BehaviorSubjects-----------------------------------------
  final _isDataAvailable = BehaviorSubject<bool>();
  final _userName = BehaviorSubject<String>();
  final _emailAddress = BehaviorSubject<String>();
  final _socialMediaId = BehaviorSubject<String>();
  final _photoURL = BehaviorSubject<String>();
  final _fbLoginStatus = BehaviorSubject<FacebookLoginStatus>();

  //-----------------------Stream-----------------------------------------------
  Stream<bool> get isDataAvailable => _isDataAvailable.stream;

  Stream<String> get userName => _userName.stream;

  Stream<String> get emailAddress => _emailAddress.stream;

  Stream<String> get socialMediaId => _socialMediaId.stream;

  Stream<String> get photoURL => _photoURL.stream;

  Stream<FacebookLoginStatus> get fbLoginStatus => _fbLoginStatus.stream;

  //-----------------------Function---------------------------------------------
  Function(bool) get sinkDataState => _isDataAvailable.sink.add;

  Function(String) get sinkUserName => _userName.sink.add;

  Function(String) get sinkEmailAddress => _emailAddress.sink.add;

  Function(String) get sinkSocialMediaId => _socialMediaId.sink.add;

  Function(String) get sinkPhotoURL => _photoURL.sink.add;

  Function(FacebookLoginStatus) get sinkFbLoginStatus =>
      _fbLoginStatus.sink.add;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuth _authForFB = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
  static final FacebookLogin facebookLogin = FacebookLogin();

  Future<Null> handleSignIn(String type) async {
    FirebaseUser currentUser;
    switch (type) {
      case "FB":
        final FacebookLoginResult facebookLoginResult =
            await facebookLogin.logIn(['email']);
        switch (facebookLoginResult.status) {
          case FacebookLoginStatus.loggedIn:
            FacebookAccessToken accessToken = facebookLoginResult.accessToken;
            final facebookAuthCred = FacebookAuthProvider.getCredential(
                accessToken: accessToken.token);
            final FirebaseUser user =
                (await _authForFB.signInWithCredential(facebookAuthCred)).user;
            print("User FB : ${user.toString()}");

            currentUser = await _authForFB.currentUser();
            sinkUserName(Platform.isIOS ? user.providerData[0].displayName : user.providerData[1].displayName);
            sinkEmailAddress(Platform.isIOS ? user.providerData[0].email : user.providerData[1].email);
            sinkSocialMediaId(Platform.isIOS ? user.providerData[0].uid : user.providerData[1].uid);
            sinkPhotoURL(Platform.isIOS ? user.providerData[0].photoUrl : user.providerData[1].photoUrl);
            sinkFbLoginStatus(facebookLoginResult.status);
            sinkDataState(true);
            break;
          case FacebookLoginStatus.cancelledByUser:
            sinkDataState(false);
            sinkFbLoginStatus(facebookLoginResult.status);
            break;
          case FacebookLoginStatus.error:
            sinkDataState(false);
            sinkFbLoginStatus(facebookLoginResult.status);
            break;
        }
        break;
      case "G":
        try {
          GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
          final googleAuth = await googleSignInAccount.authentication;
          final googleAuthCred = GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          final FirebaseUser user =
              (await _auth.signInWithCredential(googleAuthCred)).user;
          print('DATA FROM GOOGLE ${user.toString()}');

          final FirebaseUser currentUser = await _auth.currentUser();
          sinkUserName(Platform.isIOS ? user.providerData[0].displayName : user.providerData[1].displayName);
          sinkEmailAddress(Platform.isIOS ? user.providerData[0].email : user.providerData[1].email);
          sinkSocialMediaId(Platform.isIOS ? user.providerData[0].uid : user.providerData[1].uid);
          sinkPhotoURL(Platform.isIOS ? user.providerData[0].photoUrl : user.providerData[1].photoUrl);
          sinkDataState(true);
        } catch (error) {
          print(error);
        }
    }
  }

  Future<Null> signOutGoogle() async {
    await googleSignIn.signOut();
    print("Google User Signed Out");
  }

  Future<Null> signOutFacebook() async {
    await facebookLogin.logOut();
    print("FB User Signed Out");
  }

  @override
  void dispose() {
    _userName.close();
    _emailAddress.close();
    _photoURL.close();
    _socialMediaId.close();
    _isDataAvailable.close();
    _fbLoginStatus.close();
  }

  void clearAllData() {
    _userName.value = null;
    _emailAddress.value = null;
    _socialMediaId.value = null;
    _photoURL.value = null;
    _isDataAvailable.value = false;
    _fbLoginStatus.value = null;
  }
}
