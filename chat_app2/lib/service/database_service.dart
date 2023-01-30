import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection('chat');

  Future saveUserData(String userName, String userEmail) async {
    await userCollection.doc(uid).set({
      'userName': userName,
      'email': userEmail,
      'userImage': '',
    });
  }

  Future setUserImage(String url) async {
    await userCollection.doc(uid).set(
      {
        'userImage': url,
      },
      SetOptions(merge: true),
    );
  }

  getChats() async {
    return chatCollection.orderBy('time', descending: true).snapshots();
  }

  Future getUserImage(String userID) async {
    DocumentReference d = userCollection.doc(userID);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['userImage'];
  }

  Future getUserName(String userID) async {
    DocumentReference d = userCollection.doc(userID);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['userName'];
  }

  // getUserData() async {
  //   QuerySnapshot snapshot = userCollection.where('')
  // }
}
