import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DefaultAddPerson extends StatelessWidget {
  final UserModel data;
  final Color? color;
  final ValueKey? valueKey;

  const DefaultAddPerson({
    Key? key ,
    required this.data ,
    this.valueKey,
    this.color
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _checkUserBlock = StreamProvider((ref)=>BlockFunctions.checkUserBlock(data.id));
    final _checkRequests = StreamProvider((ref)=>RequestsFunction.checkRequests(data.id));
    final _checkMyRequests = StreamProvider((ref)=>RequestsFunction.checkMyRequests(data.id));

    return LayoutBuilder(
      key: valueKey,
      builder:(context, constraints) => SizedBox(
        key: valueKey,
          width: constraints.maxWidth * 0.15,
          child: Consumer(
            key: valueKey,
            builder: (context,provMyData,_){
              return provMyData.watch(_fetchMyData).when(
                  error: (err,stack)=>errorProvider(err),
                  loading: ()=>loadingVisibilityProvider() ,
                  data: (myData){
                    final UserModel _myData = UserModel.fromApp(myData.data()!);

                    return Consumer(
                      key: valueKey,
                      builder: (context,provCheckBlock,_) {
                        return provCheckBlock.watch(_checkUserBlock).when(
                            error: (err,stack)=>errorProvider(err) ,
                            loading: ()=>loadingVisibilityProvider() ,
                          data: (checkBlocks)=> AnimatedConditionalBuilder(
                            key: valueKey,
                              condition: checkBlocks.exists,
                              builder: (context){
                                return IconButton(
                                    key: valueKey,
                                    onPressed: () async {
                                  return await BlockFunctions.removeFromBlock(data.id);
                                }, icon: const Icon(Icons.person_add_disabled));
                              },
                              fallback: (context){
                                return Consumer(
                                  key: valueKey,
                                    builder:(context , provCheck , _) {
                                      return provCheck.watch(_checkMyRequests).when(
                                          error: (err,stack)=>errorProvider(err),
                                          loading: ()=>loadingVisibilityProvider(),
                                          data: (checkMyRequests)=> AnimatedConditionalBuilder(
                                            key: valueKey,
                                            condition: checkMyRequests.exists ,
                                            builder: (context){
                                              return IconButton(
                                                key: valueKey,
                                                  onPressed: () async {
                                                    await RequestsFunction.acceptRequests(
                                                        id: data.id,
                                                        model: data ,
                                                        myModel: _myData
                                                    );
                                                    await RequestsFunction.refusedRequests(data.id);
                                                    await RequestsFunction.removeRequests(data.id);
                                                  }, icon: Icon(Icons.person_add,color: color ?? lightMainColor,));
                                            },
                                            fallback: (BuildContext context){
                                              return Consumer(
                                                key: valueKey,
                                                  builder:(context,provCheck,_)=>
                                                      provCheck.watch(_checkRequests).when(
                                                        error: (err,stack)=> errorProvider(err),
                                                        loading: ()=> loadingVisibilityProvider(),
                                                        data: (checkRequests)=> AnimatedConditionalBuilder(
                                                            key: valueKey,
                                                            duration: const Duration(milliseconds: 500),
                                                            switchOutCurve: Curves.easeInOutCubic,
                                                            switchInCurve: Curves.easeInOutCubic,
                                                            condition: !checkRequests.exists ,
                                                            builder:(context)=> IconButton(
                                                              key: valueKey,
                                                                onPressed: () async {

                                                                  return await RequestsFunction.sendRequest(id: data.id,model: _myData);

                                                                }, icon: Icon(Icons.send,color: color ?? lightMainColor,)) ,
                                                            fallback:(context)=> IconButton(
                                                              key: valueKey,
                                                                onPressed: () async {
                                                                  return await RequestsFunction.removeRequests(data.id);
                                                                }, icon: Icon(Icons.delete_outline,color: color ?? lightMainColor,))
                                                        ),
                                                      )

                                              );
                                            },
                                          )
                                      );
                                    }
                                );
                              }
                          )
                        );
                      }
                    );
                  }
              );
            },
          )
      ),
    );
  }
}

final _fetchMyData = StreamProvider((ref)=>AuthFunctions.getUserData());
