import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http_app/Model/DetailsModel.dart';
import 'package:http_app/Model/User.dart';

class DataBaseService {
  final String uid;

  DataBaseService({this.uid});

  final CollectionReference personDetails =
      Firestore.instance.collection("Users Info");

  Future UpdateUserData(String email,String name,  String place,  int age) async {
    return await personDetails.document(uid).setData({
      'uid': uid,
      'email': email,
      'name': name,
      'place': place,
      'age': age,

    });
  }
  List <Details>_detailsfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Details(
        uid: uid,
        email: doc.data['email']??'NA',
        name: doc.data['name'] ?? 'NA',
        place: doc.data['place'] ?? 'NA',
        age: doc.data['age'] ?? 0 ,

      );
    }).toList();
  }

  //get stream
// Stream<List <Details>> get person {
//     return personDetails.snapshots().map(_detailsfromsnapshot);
// }

Details _userDataSnapshot(DocumentSnapshot snapshot){
    return Details(
      uid: uid,
      email: snapshot.data['email'],
      name:snapshot.data['name'],
      place :snapshot.data['place'],
      age:snapshot.data['age'],
      
    );
}
Stream<Details> get userdata{
    return personDetails.document(uid).snapshots().map(_userDataSnapshot);
}
}
