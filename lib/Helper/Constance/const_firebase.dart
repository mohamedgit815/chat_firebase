import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseStorage fireStorage = FirebaseStorage.instance;
final String firebaseId = FirebaseAuth.instance.currentUser!.uid;
final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// FireStore Variable
const String fireStoreUser = 'User';
const String fireStoreUpload = 'Uploaded';
const String fireStoreComment = 'Comment';
const String fireStoreCommentLike = 'Like';
const String fireStoreUsersChat = 'UsersChat';
const String fireStoreMyUpload = 'MyUploaded';
const String fireStoreProfile = 'Profile';
const String fireStoreLike = 'Favorite';
const String fireStoreRequests = 'Requests';
const String fireStoreFriends = 'Friends';
const String fireStoreBlocks = 'Blocks';
const String fireStoreFoods = 'Food';
const String fireStoreMeat = 'Meat';
const String fireStoreVegetables = 'Vegetables';
const String fireStoreFavorite = 'Favorite';
const String fireStoreChat = 'Chat';