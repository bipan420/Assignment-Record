import 'package:cloud_firestore/cloud_firestore.dart';
class Student {
  final String id;
  final String roll;
  final String name;
  final Timestamp dateOfBirth;
  final String gender;
  final String nextOfKin;
  final String address;

  Student({this.id,this.roll,this.name,this.dateOfBirth,this.gender,this.nextOfKin,this.address});

  factory Student.fromDoc(DocumentSnapshot doc){
    return Student (
      id: doc.documentID,
      roll: doc['roll'],
      name: doc['name'],
      dateOfBirth: doc['dateOfBirth'],
      gender: doc['gender'],
      nextOfKin: doc['nextOfKin'],
      address: doc['address'],
    );
      

  } 
}