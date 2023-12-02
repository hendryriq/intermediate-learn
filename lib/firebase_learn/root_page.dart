import 'package:flutter/material.dart';
import 'package:intermediate_learn/firebase_learn/home_page.dart';
import 'package:intermediate_learn/firebase_learn/login_signup_screen.dart';
import 'authentication.dart';

class RootPage extends StatefulWidget {
  final BaseAuth? auth;
  const RootPage({super.key, this.auth});

  @override
  State<RootPage> createState() => _RootPageState();
}

enum AuthStatus { NOT_DETERMINED, NOT_LOGGED_IN, LOGGED_IN }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String userId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth?.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          userId = user.uid;
        print("Test $userId");
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void onSignOut() async{
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      userId = "";
    });
  }

  Widget buildWaitingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  void onLoggedIn() async{
    widget.auth?.getCurrentUser().then((user){
      setState(() {
        userId = user?.uid ?? "";
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("signout $userId");
    switch (authStatus){
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
      case AuthStatus.NOT_LOGGED_IN:
        return LoginSignupPage(
          auth :widget.auth,
          onLoggedIn: onLoggedIn,
          onSignOut: onSignOut);
      case AuthStatus.LOGGED_IN:
        if(userId.isNotEmpty && userId != null){
          return HomePage(
            userId: userId,
            auth: widget.auth,
            onSignOut: onSignOut);
        }else{
          return buildWaitingScreen();
        }
      default:
        return buildWaitingScreen();
    }
  }
}
