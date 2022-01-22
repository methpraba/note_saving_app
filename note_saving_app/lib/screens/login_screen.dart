import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_saving_app/screens/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _uidFocusnode = FocusNode();
  Future<FirebaseApp> _initializeFirebase() async{
   FirebaseApp notesSavingApp = await Firebase.initializeApp();
   return notesSavingApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _uidFocusnode.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: 20.0,
                  ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                                child: Image.asset("assets/note_icon.jpg", height: 150,)
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                                'Welcome..!',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'AnyNote - Notes Saving App',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                    ),
                    ),
                    FutureBuilder(
                      future: _initializeFirebase(),
                        builder: (context, snapshot){
                        if (snapshot.hasError){
                          return Text('Error Occours When Intializing Firebase...');
                        }
                        else if (snapshot.connectionState == ConnectionState.done){
                          return Login(focusNode: _uidFocusnode);
                        }
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        );
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
