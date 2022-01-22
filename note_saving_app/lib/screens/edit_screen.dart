import 'package:flutter/material.dart';
import 'package:note_saving_app/screens/app_bar.dart';
import 'package:note_saving_app/validators/database.dart';
import 'edit.dart';

class EditScreen extends StatefulWidget {

  final String currentTitle;
  final String currentDescription;
  final String documentId;

  EditScreen({
    required this.currentTitle,
    required this.currentDescription,
    required this.documentId,
});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: AppBarTitle(
            section: 'Edit Notes',
          ),
          actions: [
            _isDeleting
            ? Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent,
                ),
                strokeWidth: 3,
              ),
            ):IconButton(
                onPressed: () async{
                  setState(() {
                    _isDeleting = true;
                  });
                  await Database.deleteNote(docId: widget.documentId,
                  );
                  setState(() {
                    _isDeleting = false;
                  });
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.blue[900],
                  size: 35,
                ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 15.0,
            ),
            child: Edit(
               documentId:widget.documentId,
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              currentTitle:widget.currentTitle,
              currentDescription: widget.currentDescription,
            ),
          ),
        ),
      ),
    );
  }
}
