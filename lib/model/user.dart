import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  String? id;
  String? name;

  User (this.id,this.name);

  static User fromDocument (String id,Map<String, dynamic> json){
    return User(
        id,
        json['name']
    );
  }

  static List<User> fromSnapshot( List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots){
    return snapshots.map((e) => fromDocument(e.id,e.data())).toList();
  }

}