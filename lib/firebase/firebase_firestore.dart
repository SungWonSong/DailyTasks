import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailytask/common/daily_todo.dart';

class DataInFireStore {
  static Future<List<DailyTodo>> getAllEntries(String collectioin, String email) async {
    var collectionReference = FirebaseFirestore.instance.collection(collection);
    var querySnapshot = await collectionReference.where('email', isEqualTo: email).get();

    List<DailyTodo> dailyTodos = querySnapshot.docs.map(doc) {
      return DailyTodo(
        id : doc.id,
        task : doc.data()['task'],
        //id외의 data는 doc.data()['명칭']을 사용해야 data를 가져올 수 있다.
        email : email,
      );
    }).toList();

    return dailyTodos;
  }
}