import 'dart:math';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatFunctions {
  /// Chats
  static Future<QuerySnapshot<Map<String,dynamic>>> fetchUserChat() async {
    return await fireStore.collection(fireStoreUser)
        .orderBy('date',descending: true).get();
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchStreamUserChat()  {
    return fireStore.collection(fireStoreUser).
        orderBy('date',descending: true).snapshots();
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchChat({
    required String id , required String name
  }) {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFriends).doc(id)
        .collection(name).orderBy('date',descending: true).snapshots();
  }

  static Future<void> updateDateChat() async {
    return await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      'date': DateTime.now()
    });
  }

  static Future<void> sendMessageChat({
    required String id , required String text ,required String name ,
    required String myName , required WidgetRef state , required String subText ,
    required ChangeNotifierProvider<SwitchState>indicatorState ,required String subUser
}) async {
    state.read(indicatorState).falseSwitch();
    final int _number = Random().nextInt(999999999);
    final int _number1 = Random().nextInt(999999999);
    final int _number2 = Random().nextInt(999999999);
    final String _dateNumber = DateTime.now().toString().substring(21,26);

    final String _random = '$_number$_dateNumber$_number1$_number2';

    await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFriends).doc(id).collection(name)
        .doc(_random).set({
      'date': Timestamp.now() ,
      'text': text ,
      'id': firebaseId ,
      'subText': subText ,
      'subUser' : subUser
    });

    await fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).doc(firebaseId)
        .collection(myName).doc(_random).set({
      'date': Timestamp.now() ,
      'text': text ,
      'id': firebaseId ,
      'subText': subText ,
      'subUser' : subUser
    });

    state.read(indicatorState).trueSwitch();
  }


  static Future<void> deleteMessageChat({
    required String id , required String deleteId ,
    required String name , required String myName
  }) async {


    await fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).doc(firebaseId)
        .collection(myName).doc(deleteId).delete();


    await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFriends).doc(id)
        .collection(name).doc(deleteId).delete();
  }


}

class FriendsFunctions {
  /// Friends

  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchFriends(){
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFriends).snapshots();
  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkFriends(String id){
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFriends).doc(id).snapshots();
  }

  static Future<void> removeFriends(String id) async {
    /// Delete To My Collection
    await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFriends).doc(id).delete();

    /// Delete To His Collection
    await fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).doc(firebaseId).delete();
  }

  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchUserFriends(String id){
    return fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).snapshots();
  }

}

class RequestsFunction {
  static Future<void> sendRequest({
    required String id , required UserModel model ,
  }) async {
    return await fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreRequests).doc(model.id).set(model.toApp());
  }


  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkRequests(String id) {
    return fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreRequests).doc(firebaseId).snapshots();
  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkMyRequests(String id) {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreRequests).doc(id).snapshots();
  }

  static Future<void> removeRequests(String id) async {
    return await fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreRequests).doc(firebaseId).delete();
  }


  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchRequests() {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreRequests).snapshots();
  }

  static Future<void> refusedRequests(String id) async {
    return await fireStore.collection(fireStoreProfile)
        .doc(firebaseId).collection(fireStoreRequests).doc(id).delete();
  }

  static Future<void> acceptRequests({
    required String id ,
    required UserModel model ,
    required UserModel myModel
  }) async {
    /// Send To My Collection
    await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreFriends).doc(id).set(model.toApp());

    /// Send To His Collection
    await fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreFriends).doc(firebaseId).set(myModel.toApp());
  }
}

class BlockFunctions {
  static Future<void> addToBlock({
    required UserModel model ,
  }) async {
    return await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreBlocks).doc(model.id).set(model.toApp());
  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkUserBlock(String id) {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreBlocks).doc(id).snapshots();
  }

  static Stream<DocumentSnapshot<Map<String,dynamic>>> checkUserBlockOrNo(String id) {
    return fireStore.collection(fireStoreProfile).doc(id)
        .collection(fireStoreBlocks).doc(firebaseId).snapshots();
  }

  static Future<void> removeFromBlock(String id) async {
    return await fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreBlocks).doc(id).delete();
  }


  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchBlock() {
    return fireStore.collection(fireStoreProfile).doc(firebaseId)
        .collection(fireStoreBlocks).orderBy('date', descending: true).snapshots();
  }
}