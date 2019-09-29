import 'package:flutter/material.dart';
import 'package:sign_in_flutter/loginPage.dart';
import 'package:sign_in_flutter/src/bloc/mainBloc.dart';

class FirstScreen extends StatelessWidget {
  MainBloc mMainBloc;

  FirstScreen({this.mMainBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: mMainBloc.isDataAvailable,
          builder: (context, snapshot) {
            return snapshot.hasData && snapshot.data != false ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  StreamBuilder(
                      stream: mMainBloc.photoURL,
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data != null ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            snapshot.data,
                          ),
                          radius: 60,
                          backgroundColor: Colors.transparent,
                        ) : CircularProgressIndicator();
                      }
                  ),
                  SizedBox(height: 40),
                  Text(
                    'NAME',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  StreamBuilder(
                      stream: mMainBloc.userName,
                      builder: (context, snapshot) {
                        print('NAME ${snapshot.data.toString()}');
                        return Text(
                          snapshot.hasData && snapshot.data != null ? snapshot.data : 'Loading',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        );
                      }
                  ),
                  SizedBox(height: 20),
                  Text(
                    'EMAIL',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  StreamBuilder(
                      stream: mMainBloc.emailAddress,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData && snapshot.data != null ? snapshot.data : 'Loading',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        );
                      }
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'SOCIAL MEDIA ID',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  StreamBuilder(
                      stream: mMainBloc.socialMediaId,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData && snapshot.data != null ? snapshot.data : 'Loading',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        );
                      }
                  ),
                  SizedBox(height: 40),
                  RaisedButton(
                    onPressed: () {
                      mMainBloc.signOutGoogle();
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
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                  )
                ],
              ),
            ) : Center(
              child: Container(
                height: 200.0,
                width: 200.0,
                child: CircularProgressIndicator(),
              ),
            );
          }
        ),
      ),
    );
  }
}
