import 'package:flutter/material.dart';
import 'package:sign_in_flutter/firstScreen.dart';
import 'package:sign_in_flutter/secondScreen.dart';
import 'package:sign_in_flutter/src/bloc/blocProvider.dart';
import 'package:sign_in_flutter/src/bloc/mainBloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MainBloc mainBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButtonForGoogle(),
              SizedBox(height: 30),
              _signInButtonForFacebook(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButtonForGoogle() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        mainBloc.handleSignIn('G');
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstScreen(mMainBloc: mainBloc,)));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _signInButtonForFacebook() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        mainBloc.handleSignIn('FB');
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SecondScreen(mMainBloc: mainBloc,)));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/facebook_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Facebook',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    mainBloc.clearAllData();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainBloc = BlocProvider.of(context);
    mainBloc.sinkUserName('Loading');
    mainBloc.sinkEmailAddress('Loading');
    mainBloc.sinkSocialMediaId('Loading');
    mainBloc.sinkDataState(false);
  }
}
