import 'package:flutter/material.dart';
import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_widgets.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_textformfield.dart';
import 'package:chat_app/Helper/Widgets/Defaults/defualt_expandedauth.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';
import 'package:chat_app/Views/Authentications/Login/main_login_screen.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileSignUpPage extends ConsumerStatefulWidget {
  const MobileSignUpPage({Key? key}) : super(key: key);

  @override
  _MobileSignUpPage createState() => _MobileSignUpPage();
}


class _MobileSignUpPage extends ConsumerState<MobileSignUpPage> with _MobileRegisterClass{

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstController.dispose();
    _lastController.dispose();
    _emailController.dispose();
    _pwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool _keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    final Size _mediaQ = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xff9D84BB),
                      Color(0xff9A81B7),
                    ]
                )
            ),
            child: LayoutBuilder(
              builder:(BuildContext buildContext , BoxConstraints constraints) => Form(
                key: _globalKey ,
                child: ListView(
                    children: [

                      SizedBox(
                        height: _keyBoard ? constraints.maxHeight : _mediaQ.height * 0.7,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [
                            const CustomText(
                              text: 'Create Account',
                              fontSize: 24.0,
                              color: normalWhite ,
                            ) ,

                            const SizedBox(height: 30.0) ,

                            DefaultExpandedAuth(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 12,
                                    child: DefaultTextFormField(
                                        controller: _firstController,
                                        fillColor: normalWhite ,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0) ,
                                            borderSide: BorderSide.none
                                        ),
                                        hintStyle: const TextStyle(
                                            fontSize: 19.0,
                                            color: normalGrey
                                        ),
                                        style: const TextStyle(
                                            fontSize: 19.0,
                                            color: normalBlack
                                        ),
                                        hint: 'First',
                                        validator: (v){
                                          return ConstValidator.validatorName(v);
                                        },
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.next
                                    ),
                                  ),

                                  const Spacer(),

                                  Expanded(
                                    flex: 12,
                                    child: DefaultTextFormField(
                                        controller: _lastController,
                                        fillColor: normalWhite ,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0) ,
                                            borderSide: BorderSide.none
                                        ),
                                        hintStyle: const TextStyle(
                                            fontSize: 19.0,
                                            color: normalGrey
                                        ),
                                        style: const TextStyle(
                                            fontSize: 19.0,
                                            color: normalBlack
                                        ),
                                        hint: 'Last',
                                        validator: (v){
                                          return ConstValidator.validatorName(v);
                                        },
                                        inputType: TextInputType.text,
                                        inputAction: TextInputAction.next
                                    ),
                                  ),
                                ],
                              ),
                            ) ,

                            const SizedBox(height: 20.0) ,

                            DefaultExpandedAuth(
                              child: DefaultTextFormField(
                                  controller: _emailController,
                                  fillColor: normalWhite ,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0) ,
                                      borderSide: BorderSide.none
                                  ),
                                  hintStyle: const TextStyle(
                                      fontSize: 19.0,
                                      color: normalGrey
                                  ),
                                  style: const TextStyle(
                                      fontSize: 19.0,
                                      color: normalBlack
                                  ),
                                  hint: 'Enter your Email',
                                  validator: (v){
                                    return ConstValidator.validatorEmail(v);
                                  },
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next
                              ),
                            ) ,

                            const SizedBox(height: 20.0) ,

                            DefaultExpandedAuth(
                              child: Consumer(
                                  builder: (context,prov,_) {
                                    return DefaultTextFormField(
                                      controller: _pwController,
                                      fillColor: normalWhite ,
                                      password: prov.watch(_visiblePwProv).varSwitch,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20.0) ,
                                          borderSide: BorderSide.none
                                      ),
                                      hintStyle: const TextStyle(
                                          fontSize: 19.0 ,
                                          color: normalGrey
                                      ),
                                      style: const TextStyle(
                                          fontSize: 19.0 ,
                                          color: normalBlack
                                      ),
                                      suffixIcon: AnimatedConditionalBuilder(
                                        condition: prov.read(_visiblePwProv).varSwitch,
                                        builder: (BuildContext context){
                                          return ConstWidgets.iconButtonVisibility(
                                              ref: prov,
                                              color: normalBlack,
                                              icon: Icons.visibility,
                                              state: _visiblePwProv
                                          );
                                        },
                                        fallback: (BuildContext context){
                                          return ConstWidgets.iconButtonVisibility(
                                              ref: prov,
                                              color: normalBlack,
                                              icon: Icons.visibility_off,
                                              state: _visiblePwProv
                                          );
                                        },
                                      ),
                                      hint: 'Enter your Password',
                                      validator: (v){
                                        return v!.isEmpty ? 'Enter your Password by Right Form' : null;
                                      },
                                      inputType: TextInputType.visiblePassword,
                                      inputAction: TextInputAction.done,
                                      onSubmitted: (String v) async {
                                        return await AuthFunctions.registerAuth(
                                            globalKey: _globalKey,
                                            route: MainLoginScreen.login,
                                            first: _firstController.text.trim(),
                                            email: _emailController.text,
                                            last: _lastController.text.trim(),
                                            password: _pwController.text,
                                            context: context,
                                            indicatorState: _indicatorProv,
                                            state: ref);
                                      },
                                    );
                                  }
                              ),
                            ) ,

                            const SizedBox(height: 20.0) ,

                            DefaultExpandedAuth(
                              child: Consumer(
                                builder:(buildContext,prov,_)=> Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0
                                  ),
                                  child: AnimatedConditionalBuilder(
                                    condition: prov.watch(_indicatorProv).varSwitch,
                                    builder: (BuildContext buildContext){
                                      return CustomTextButton(
                                        size: const Size(double.infinity,50.0),
                                        backGroundColor: const Color(0xffCA9EFF),
                                        child: const CustomText(text: 'SignUp',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24.0,
                                          color: normalWhite ,
                                        ),
                                        borderRadius: BorderRadius.circular(20.0),
                                        onPressed: () async {
                                          return await AuthFunctions.registerAuth(
                                              globalKey: _globalKey,
                                              route: MainLoginScreen.login,
                                              first: _firstController.text,
                                              email: _emailController.text,
                                              last: _lastController.text,
                                              password: _pwController.text,
                                              context: context,
                                              indicatorState: _indicatorProv,
                                              state: prov
                                          );
                                        },
                                      );
                                    },
                                    fallback: (BuildContext context){
                                      return loadingProvider();
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )

                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _MobileRegisterClass {
  final _indicatorProv= ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _visiblePwProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
}