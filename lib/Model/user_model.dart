import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String first , last , email , image , id , bio , token;
  final Timestamp date;
  final bool page;

  UserModel({
    required this.bio , required this.first , required this.last ,
    required this.email, required this.image, required this.id ,
    required this.token ,required this.date , required this.page
  });

  factory UserModel.fromApp(Map<String,dynamic>map){
    return UserModel(
        first: map['first'],
        last: map['last'],
        email: map['email'] ,
        image: map['image'],
        id: map['id'] ,
        bio: map['bio'] ,
        token: map['token'] ,
        date: map['date'] ,
      page: map['page']
    );
  }

  Map<String,dynamic> toApp()=>{
    'first' : first ,
    'last' : last ,
    'email' : email ,
    'image' : image ,
    'id' : id ,
    'bio': bio ,
    'token': token,
    'date' : date ,
    'page': page
  };
}