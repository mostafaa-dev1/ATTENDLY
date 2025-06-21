import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static var db = FirebaseFirestore.instance;

  static Future<void> addData(
      Map<String, dynamic> data, String collection, String id) async {
    await db.collection(collection).doc(id).set(data);
  }

  static Future<void> addDataByCollection(Map<String, dynamic> data,
      String collection1, String id, String collection2, String id2) async {
    await db
        .collection(collection1)
        .doc(id)
        .collection(collection2)
        .doc(id2)
        .set(data);
  }

  static Future<void> updateData(
      Map<String, dynamic> data, String collection, String id) async {
    await db.collection(collection).doc(id).update(data);
  }

  static Future<void> updateDatabyCollectionandSubCollection({
    required String collection,
    required String id,
    required String subCollection,
    required String id2,
    required Map<String, dynamic> data,
  }) async {
    var response = await db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .doc(id2)
        .update(data);

    return response;
  }

  static Future<void> deleteData(String collection, String id) async {
    await db.collection(collection).doc(id).delete();
  }

  static Future<List<Map<String, dynamic>>> readData(String collection) async {
    var response = await db.collection(collection).get();
    return response.docs.map((e) => e.data()).toList();
  }

  static Future<List<Map<String, dynamic>>> readDataByCollection(
      String collection, String id, String subCollection) async {
    var response =
        await db.collection(collection).doc(id).collection(subCollection).get();
    return response.docs.map((e) => e.data()).toList();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>?>
      readDataByCollectionandSubCollection(String collection, String id,
          String subCollection, String id2) async {
    var response = await db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .doc(id2)
        .get();
    return response;
  }

  static Future<void> setDataByCollectionandSubCollection(
      String collection,
      String id,
      String subCollection,
      String id2,
      Map<String, dynamic> data) async {
    await db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .doc(id2)
        .set(
          data,
        );
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> readDataById(
      String collection, String id) async {
    var response = await db.collection(collection).doc(id).get();
    return response;
  }

  static Future<void> deleteDataByCollectionandSubCollection(
      String collection, String id, String subCollection, String id2) async {
    await db
        .collection(collection)
        .doc(id)
        .collection(subCollection)
        .doc(id2)
        .delete();
  }
}
