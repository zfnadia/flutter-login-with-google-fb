import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:sign_in_flutter/loginPage.dart';
import 'package:sign_in_flutter/src/bloc/mainBloc.dart';

class SecondScreen extends StatelessWidget {
  MainBloc mMainBloc;

  SecondScreen({this.mMainBloc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
            stream: mMainBloc.isDataAvailable,
            builder: (context, isDataAvailableSnapshot) {
              return StreamBuilder(
                  stream: mMainBloc.fbLoginStatus,
                  builder: (context, fbLoginStatusSnapshot) {
                    return isDataAvailableSnapshot.hasData &&
                            isDataAvailableSnapshot.data != false &&
                            fbLoginStatusSnapshot.data ==
                                FacebookLoginStatus.loggedIn
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                StreamBuilder(
                                    stream: mMainBloc.photoURL,
                                    builder: (context, snapshot) {
                                      return snapshot.hasData &&
                                              snapshot.data != null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                snapshot.data,
                                              ),
                                              radius: 60,
                                              backgroundColor:
                                                  Colors.transparent,
                                            )
                                          : CircularProgressIndicator();
                                    }),
                                SizedBox(height: 40),
                                Text(
                                  'NAME',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                StreamBuilder(
                                    stream: mMainBloc.userName,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData &&
                                                snapshot.data != null
                                            ? snapshot.data
                                            : 'Loading',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }),
                                SizedBox(height: 20),
                                Text(
                                  'EMAIL',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                StreamBuilder(
                                    stream: mMainBloc.emailAddress,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData &&
                                                snapshot.data != null
                                            ? snapshot.data
                                            : 'Loading',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'SOCIAL MEDIA ID',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                                StreamBuilder(
                                    stream: mMainBloc.socialMediaId,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData &&
                                                snapshot.data != null
                                            ? snapshot.data
                                            : 'Loading',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }),
                                SizedBox(height: 40),
                                RaisedButton(
                                  onPressed: () {
                                    mMainBloc.signOutFacebook();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginPage();
                                    }), ModalRoute.withName('/'));
                                  },
                                  color: Colors.blueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Sign Out',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  ),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                )
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 200,
                                  width: 200,
                                  child: CircularProgressIndicator(),
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                Text(fbLoginStatusSnapshot.data != null
                                    ? 'ERROR TYPE: ${fbLoginStatusSnapshot.data.toString()}'
                                    : 'ERROR TYPE: Loading'),
                              ],
                            ),
                          );
                  });
            }),
      ),
    );
  }
}
