import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/layout/social_app/social_layout.dart';
import 'package:projects/modules/shop_app/login/cubit/states.dart';
import 'package:projects/modules/social_app/social_login_screen/cubit/cubit.dart';
import 'package:projects/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:projects/modules/social_app/social_register/social_register_screen.dart';
import 'package:projects/shared/network/local/cach_helper.dart';

class SocialLoginScreen extends StatelessWidget {
var formKey=GlobalKey<FormState>();
var emailController=TextEditingController();
var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (contetx,state){
          if(state is ShopLoginErrorState)
          {
            showToast(
                text:'error',
                state: ToastState.ERROR);
          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveData(
                key:'uId',
                value:state.uId,
            ).then((value)
            {
              navigateAndFinish(
                  context,
                  SocialLayout());
            });
          }
        },
        builder: (context,state)
        {
         return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView (
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text('LOGIN',
                          style:Theme.of(context).textTheme.headline4!.copyWith(
                            color:Colors.black,
                          ),
                        ),
                        SizedBox(
                          height:15.0,),
                        Text(
                          'login now to communicate with friends',
                          style:Theme.of(context).textTheme.bodyText1!.copyWith(
                            color:Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                    defaultFormFeild(
                      controller: emailController,
                      type:TextInputType.emailAddress,

                      validate:(String value){
                        if(value.isEmpty)
                        {
                          return'email must not be empty';
                        }
                      },
                      label: 'Email Address',
                      prefix:Icons.email,
                    ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                          controller: passwordController,
                          type:TextInputType.visiblePassword,
                          suffix: SocialLoginCubit.get(context).suffix,
                          suffixedpressed: (){
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },

                          ispassword: SocialLoginCubit.get(context).isPassword,
                          onFieldSubmit:(value){
                            if(formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                   password: passwordController.text);
                            }
                          },
                          validate:(String value){
                            if(value.isEmpty)
                            {
                              return'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix:Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder:(context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?' ),
                            TextButton(
                                onPressed:(){
                                  navigateTo(
                                    context,
                                     SocialRegisterScreen(),);
                                },
                                child:Text('register'.toUpperCase(),))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
