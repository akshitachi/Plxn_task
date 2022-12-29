import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class DataBaseService {
  var database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: "https://plxntask-5de63-default-rtdb.firebaseio.com/")
      .ref();

  Future getUserdetails() async {
    var result = await database.child('Users').get().then((data) => data.value);
    return result;
  }
}
