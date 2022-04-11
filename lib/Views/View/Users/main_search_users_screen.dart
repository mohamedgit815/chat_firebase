import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_add_person.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUsers extends SearchDelegate {
  late String image , first , last , email , bio , id;
  final _fetchUser = StreamProvider((ref)=>ChatFunctions.fetchStreamUserChat().asBroadcastStream());


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, 0);
    }, icon: Icon(Icons.adaptive.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final _checkRequests = StreamProvider((ref)=>RequestsFunction.checkRequests(id));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0
          ),
          child: CircleAvatar(
            radius: 50.0,
            backgroundColor: image.isEmpty? lightMainColor: null,
            backgroundImage: image.isEmpty? null: NetworkImage(image),
            child: CustomText(
              text: first.substring(0,1).toString(),
              fontSize: 40.0,
              color: normalWhite,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child:  CustomText(
            text: 'Name: $first $last' ,
            fontSize: 20.0,
          ),
        ),


        AnimatedConditionalBuilder(
          condition: bio.isEmpty,
          builder: (context)=> CustomText(
            text: 'Email: $email' ,
            fontSize: 17.0,
          ),
          fallback: (context)=> CustomText(
            text: 'Bio: $bio' ,
            fontSize: 17.0,
          ),

        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomElevatedButton(onPressed: (){
            }, child: const Text('Favorite')),

            CustomElevatedButton(onPressed: (){
            }, child: const Text('Uploaded')),

            Consumer(
                builder:(context,provCheck,_)=> provCheck.watch(_checkRequests).when(
                  error: (err,stack)=>errorProvider(err),
                  loading: ()=>const Icon(Icons.send,color: lightMainColor,),
                  data: (checkRequests)=>AnimatedConditionalBuilder(
                    duration: const Duration(milliseconds: 500),
                    switchOutCurve: Curves.easeInOutCubic,
                    switchInCurve: Curves.easeInOutCubic,
                    condition: !checkRequests.exists ,
                    builder:(context)=> Consumer(
                        builder:(context,provMyData,_)=> provMyData.watch(myDataProv).when(
                          error: (err,stack)=>errorProvider(err),
                          loading: ()=>loadingProvider() ,
                          data: (myData)=>IconButton(
                              onPressed: () async {
                                final UserModel _myData = UserModel.fromApp(myData.data()!);

                                return await RequestsFunction.sendRequest(id: id,model: _myData);

                              }, icon: const Icon(Icons.send,color: lightMainColor,)) ,
                        )
                    ),
                    fallback:(context)=> IconButton(onPressed: () async {
                      return await RequestsFunction.removeRequests(id);
                    }, icon: const Icon(Icons.delete_outline,color: lightMainColor,)),
                  ),

                )
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return Consumer(
        builder: (context,prov,_)=>prov.watch(_fetchUser).when(
            error: (err,stack)=> errorProvider(err),
            loading: ()=> loadingProvider() ,
            data: (data) {

              final List<QueryDocumentSnapshot<Map<String,dynamic>>> _searchData = data.docs.where((element){
                return element.get('first').toString().toLowerCase()
                    .contains(query.toLowerCase()) ||
                    element.get('last').toString().toLowerCase()
                        .contains(query.toLowerCase());
              }).toList();

              return ListView.builder(
                  itemCount: _searchData.length ,
                  itemBuilder: (context,i){
                    final UserModel _search = UserModel.fromApp(_searchData.elementAt(i).data());
                    final _checkFriends = StreamProvider((ref)=>FriendsFunctions.checkFriends(_search.id));

                    return Consumer(
                        builder:(context,provCheck,_)=> provCheck.watch(_checkFriends).when(
                          error: (err,stack)=>errorProvider(err),
                          loading: ()=>loadingVisibilityProvider() ,
                          data: (check)=>Visibility(
                            visible: _search.id == firebaseId || check.exists ? false : true,
                            child: InkWell(
                              onTap: (){
                                image = _search.image;
                                first = _search.first;
                                last = _search.last;
                                bio = _search.bio;
                                email = _search.email;
                                id = _search.id;
                                showResults(context);
                              },
                              child: ListTile(
                                title: Text('${_search.first} ${_search.last}'),
                                subtitle: Text(_search.bio.toString()),
                                trailing: DefaultAddPerson(data: _search),
                                leading: CircleAvatar(
                                  backgroundColor: _search.image.isEmpty ? lightMainColor : null,
                                  backgroundImage: _search.image.isEmpty ? null : NetworkImage(_search.image),
                                  child: CustomText(
                                    text: _search.first.substring(0,1).toString(),
                                    fontSize: 20.0 ,
                                    color: normalWhite ,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    );
                  });
            }
        ));
  }

}

