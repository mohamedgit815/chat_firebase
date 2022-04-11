import 'dart:io';
import 'dart:math';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PostsFunctions {
  static final int _randomNumber = Random().nextInt(999999);

  /// Upload Post
 static Future<void> uploadPosts({
    File? file , required String post ,
   required BuildContext context , required WidgetRef state ,
   required ChangeNotifierProvider<SwitchState> indicatorState ,
   required UserModel userModel
}) async {
   try {
     state.read(indicatorState).falseSwitch();

     /// To Upload Image to Firebase
     late String image = '';
     if (file != null) {
       final Reference _storage = fireStorage.ref(
           '$firebaseId/$_randomNumber${file.path
               .split('/')
               .last}');
       final UploadTask _getUrl = _storage.putFile(file);
       image = await (await _getUrl).ref.getDownloadURL();
     }


     /// To send Post To Collection Firebase
     await fireStore.collection(fireStoreProfile).doc(firebaseId)
         .collection(fireStoreMyUpload).add({
       'post': post ,
       'image': image ,
       'comment': [] ,
       'date': Timestamp.now()
     });

     /// To send Post Global Firebase
     await fireStore.collection(fireStoreUpload).add({
       'post': post,
       'image': image,
       'myName': '${userModel.first} ${userModel.last}',
       'myId': userModel.id,
       'myImage': userModel.image,
       'date': Timestamp.now()
     });

     state.read(indicatorState).trueSwitch();
   } catch(e) {
     customSnackBar(text: 'Check your Internet', context: context);
   }
 }

  /// Add Comment
  static Future<DocumentReference> writeComment({
  required String id , required String comment , required String myId ,
    required String name , required String image
}) async {

   return await fireStore.collection(fireStoreUpload).doc(id)
       .collection(fireStoreComment).add({
     'comment': comment ,
     'id': myId ,
     'image': image ,
     'name': name ,
     'date': Timestamp.now() ,
   });
  }

  /// Update Comment
  static Future<void> updateComment({
    required String id ,
    required String comment ,
    required String idComment
  }) async {

    return await fireStore.collection(fireStoreUpload).doc(id)
        .collection(fireStoreComment).doc(idComment).update({
      'comment': comment ,
      'date': Timestamp.now()
    });
  }

  /// Delete Comment
  static Future<void> deleteComment({required String id, required String idComment}) async {
   return await fireStore.collection(fireStoreUpload)
       .doc(id).collection(fireStoreComment).doc(idComment).delete();
  }

  /// Fetch Comment Data

  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchComment(String id){
    return fireStore.collection(fireStoreUpload).doc(id).collection(fireStoreComment)
        .orderBy('date',descending: true).snapshots();
  }


  /// Like Comment
 static likeComment({
    required String id , required String idComment
}){
   fireStore.collection(fireStoreUpload).doc(id)
       .collection(fireStoreComment).doc(idComment)
       .collection(fireStoreCommentLike).doc(firebaseId).set({
     'id': firebaseId ,
   });
 }

 /// Check Like Comment

 static Stream<DocumentSnapshot<Map<String,dynamic>>> checkLikeComment({
     required String idComment , required String id
}) {
   return fireStore.collection(fireStoreUpload).doc(id)
       .collection(fireStoreComment).doc(idComment)
       .collection(fireStoreCommentLike).doc(firebaseId).snapshots();
 }

 /// Remove Like Comment
  static Future<void> removeLikeComment({
    required String idComment , required String id
}) async {
    await fireStore.collection(fireStoreUpload).doc(id)
        .collection(fireStoreComment).doc(idComment)
        .collection(fireStoreCommentLike).doc(firebaseId).delete();
  }
  
  /// Fetch Like Comment
  static Stream<QuerySnapshot<Map<String ,dynamic>>> fetchLikeComment({
    required String id , required String idComment
  }){
    return fireStore.collection(fireStoreUpload).doc(id)
        .collection(fireStoreComment).doc(idComment)
        .collection(fireStoreCommentLike).snapshots();
  }
}


class CommentUsersFunctions {
  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchCommentChatUsers({required String idPost,required String idComment}) {
    return fireStore.collection(fireStoreUpload).doc(idPost)
        .collection(fireStoreComment).doc(idComment).collection(fireStoreUsersChat)
        .orderBy('date',descending: true).snapshots();
  }

  static Future<DocumentReference<Map<String,dynamic>>> postCommentUser({
    required String idPost , required String idUser , required String myId ,
    required String name , required String image , required String reply ,
  }) async {
    return await fireStore.collection(fireStoreUpload).doc(idPost)
        .collection(fireStoreComment).doc(idUser).collection(fireStoreUsersChat).add({
      'id': myId ,
      'name': name ,
      'image': image ,
      'reply': reply ,
      'date' : DateTime.now()
    });
  }
}