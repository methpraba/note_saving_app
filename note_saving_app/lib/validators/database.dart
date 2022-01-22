
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class Database{
  static String? userID;

  static Future<void> addNote({
  required String title,
  required String description,
})async{
    DocumentReference documentReference = _mainCollection.doc(userID).collection('notes').doc();
    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };
    await documentReference.set(data).whenComplete(() => print("Note added to the database")).catchError((e)=> print(e));
  }
  static Future<void> updateNote({
    required String title,
    required String description,
    required String docId,
  })async{
    DocumentReference documentReference = _mainCollection.doc(userID).collection('notes').doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };
    await documentReference.set(data).whenComplete(() => print("Note updated in the database")).catchError((e)=> print(e));
  }
  static Stream<QuerySnapshot> readNote(){
    CollectionReference notesItemCollection = _mainCollection.doc(userID).collection('notes');
    return notesItemCollection.snapshots();
  }
  static Future<void> deleteNote({
    required String docId,
  })async{
    DocumentReference documentReference = _mainCollection.doc(userID).collection('notes').doc(docId);

    await documentReference.delete().whenComplete(() => print("Note deleted from the database")).catchError((e)=> print(e));
  }

}