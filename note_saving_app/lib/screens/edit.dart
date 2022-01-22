import 'package:flutter/material.dart';
import 'package:note_saving_app/custom_form.dart';
import 'package:note_saving_app/validators/validator.dart';
import 'package:note_saving_app/validators/database.dart';

class Edit extends StatefulWidget {

  final String documentId;
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final String currentTitle;
  final String currentDescription;

  const Edit({
    required this.documentId,
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.currentTitle,
    required this.currentDescription,
});


  @override
  _EditState createState() => _EditState();
}
class _EditState extends State<Edit> {

  final _addFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String updateTitle = "";
  String updateDescription = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _addFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7.0, right: 7.0, bottom: 20.0),
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
                    initialValue: widget.currentTitle,
                    isLabelEnabled: false,
                    controller: _titleController,
                    focusNode: widget.titleFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      Validator.validateField(
                        value: value,
                      );
                      updateTitle = value;
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
                    initialValue: widget.currentDescription,
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
                      updateDescription = value;
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
                    await Database.updateNote(
                      docId: widget.documentId,
                      title: updateTitle,
                      description: updateDescription,
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
                    'Update Note',
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


