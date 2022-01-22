import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_saving_app/custom_form.dart';
import 'package:note_saving_app/validators/database.dart';
import 'package:note_saving_app/validators/validator.dart';
import 'home.dart';


class Login extends StatefulWidget {
  final FocusNode focusNode;
  const Login({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _uidController = TextEditingController();

  final _loginInFormKey = GlobalKey<FormState>();

  String getId ="";


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginInFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 7.0, bottom: 24.0),
            child: Column(
              children: [
                CustomForm(
                    isObscure: true,
                    initialValue: "",
                    controller: _uidController,
                    focusNode: widget.focusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    label: 'Unique User ID',
                    hint: 'Enter Your User ID',
                    validator: (value) {
                    Validator.validateField(
                      value: value,
                    );
                    getId = value;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  ),
                ),
                onPressed: (){
                  widget.focusNode.unfocus();
                  if(_loginInFormKey.currentState!.validate()){
                    Database.userID = getId;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=> HomeScreen(),
                               ),
                            );
                          }
                        },
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0,),
                  child: Text(
                      'Login',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
