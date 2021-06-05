import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;

// Future<void> addUserData(Map<String,dynamic> _mapValue) async {
//   print("added user");
//     await databaseReference.collection("users").document(_mapValue["id"]).setData(_mapValue);
// }

Future<void> addReportData(Map<String,dynamic> _mapValue) async {
  print("added report");
  _mapValue["timestamp"]= FieldValue.serverTimestamp();
  // await databaseReference.collection("reports").document(DateFormat('dd/mm/yyyy hh:mm a').format(DateTime.now()).toString()).setData(_mapValue);
  await databaseReference.collection("reports").add(_mapValue);
}

Future<void> addEventData(Map<String,dynamic> _mapValue) async {
  print("added event");
  _mapValue["timestamp"]= FieldValue.serverTimestamp();
  // await databaseReference.collection("reports").document(DateFormat('dd/mm/yyyy hh:mm a').format(DateTime.now()).toString()).setData(_mapValue);
  await databaseReference.collection("events").add(_mapValue);
}