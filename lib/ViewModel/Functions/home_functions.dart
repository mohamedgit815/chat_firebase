import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeFunctions {
  static Future<QuerySnapshot<Map<String,dynamic>>> fetchHomeData() async {
    return await fireStore.collection(fireStoreUpload).orderBy('date',descending: true).get();
  }

  static Future<void> removePosts(String id) async {
    return await fireStore.collection(fireStoreUpload).doc(id).delete();
  }


  // static Future<void> addPostToLike(String id , HomeModel model) async {
  //   return await fireStore.collection(fireStoreProfile)
  //       .doc(firebaseId).collection(fireStoreLike).doc(id).set(model.toApp());
  // }


  static Future<void> removePostToLike(String id) async {
    return await fireStore.collection(fireStoreProfile)
        .doc(firebaseId).collection(fireStoreLike).doc(id).delete();
  }


  /// Check Post There on Favorite or No
  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkPost(String id) {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreLike).doc(id).snapshots();
  }



}