import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:note_saving_app/custom_form.dart';
import 'package:note_saving_app/validators/validator.dart';
import 'package:note_saving_app/validators/database.dart';

class Add extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const Add({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
});

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  final _addFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String getTitle = "";
  String getDescription = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _addFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 7.0, right: 7.0, bottom: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0,),
                    Text(
                      'Title',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    CustomForm(
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _titleController,
                      focusNode: widget.titleFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        Validator.validateField(
                          value: value,
                        );
                        getTitle = value;
                      },

                      label: 'Title',
                      hint: 'Enter Note Title',
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    CustomForm(
                      initialValue:"",
                      maxLines: 20,
                      isLabelEnabled: false,
                      controller: _descriptionController,
                      focusNode: widget.descriptionFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        Validator.validateField(
                          value: value,
                        );
                        getDescription = value;
                      },

                      label: 'Description',
                      hint: 'Enter Note Description',
                    ),
                  ],
                ),
              ),
              _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ): Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                  onPressed: ()async{
                    widget.titleFocusNode.unfocus();
                    widget.descriptionFocusNode.unfocus();

                    if(_addFormKey.currentState!.validate()){
                      setState(() {
                        _isProcessing = true;
                      });
                      await Database.addNote(
                          title: getTitle,
                          description: getDescription,
                      );
                      setState(() {
                        _isProcessing = false;
                      });
                      Navigator.of(context).pop();
                    }


                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text(
                      'Add Note',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }
}

