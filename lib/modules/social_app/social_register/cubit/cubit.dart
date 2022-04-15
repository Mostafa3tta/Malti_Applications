
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/models/social_app/social_user_model.dart';
import 'package:projects/modules/social_app/social_register/cubit/states.dart';
import 'package:projects/shared/network/end_points.dart';
import 'package:projects/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

static SocialRegisterCubit get(context)=>BlocProvider.of(context);
 //late ShopLoginModel loginModel;
void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
}){
  print('hello');
  emit(SocialRegisterLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
   ).then((value)
   {
     print(value.user!.email);
     print(value.user!.uid);
  userCreate(
      name: name,
      email: email,
      phone: phone,
      uId: value.user!.uid
  );
   }).catchError((error){
     SocialRegisterErrorState(error.toString());
   });
}

void userCreate({
  required String name,
  required String email,
  required String phone,
  required String uId,
})
{
  SocialUserModel model=SocialUserModel(
    name:name,
    email:email,
    phone:phone,
    uId:uId,
    cover:'https://image.freepik.com/free-photo/close-up-portrait-nice-cute-adorable-smiling-charming-cheerful-girl-pointing-with-her-index-finger_176532-7923.jpg',
    bio:'write your bio...',
    image:'https://image.freepik.com/free-photo/close-up-portrait-nice-cute-adorable-smiling-charming-cheerful-girl-pointing-with-her-index-finger_176532-7923.jpg',
    isEmailVerified: false,
  );
   FirebaseFirestore.instance
       .collection('users')
       .doc(uId)
       .set(model.toMap())
       .then((value)
   {
     emit(SocialCreateUserSuccessState());
   }).catchError((error)
   {
     emit(SocialCreateUserErrorState(error.toString()));
   });
}
IconData suffix=Icons.visibility_outlined;
bool isPassword=true;
void changePasswordVisibility(){
  isPassword=!isPassword;
  suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
  emit(SocialChangePasswordState());
}
}