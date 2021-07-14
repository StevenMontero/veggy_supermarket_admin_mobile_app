
import 'package:admin/models/email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class EmailRepository {
  late CollectionReference<Map<String, dynamic>> _emailListReference;
  CollectionReference correosElectronicos = FirebaseFirestore.instance.collection('CORREOS ELECTRONICOS');


  Future<List<Email>> getEmails() async{

    _emailListReference = FirebaseFirestore.instance.collection('CORREOS ELECTRONICOS');
    final QuerySnapshot<Map<String, dynamic>> _result;

    _result = await _emailListReference.get();

    return _result.docs.map((e) => Email.fromJson(e.data())).toList();

  }

  Future<bool> saveEmail(String receivedEmail) async{

    bool returnValue = false;

    correosElectronicos.add({
      'correo': receivedEmail,
    })
        .then((value) => print("Email added"))
        .catchError((error) => print("Failed to add email: $error"));

    return returnValue;
  }
}

