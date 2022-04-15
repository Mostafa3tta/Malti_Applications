
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/constants.dart';
import 'package:projects/layout/shop_app/shop_layout.dart';
import 'package:projects/modules/shop_app/login/cubit/cubit.dart';
import 'package:projects/modules/shop_app/register/cubit/cubit.dart';
import 'package:projects/modules/shop_app/register/cubit/states.dart';
import 'package:projects/shared/network/local/cach_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status)
            {
              CacheHelper.saveData(key: 'token',
                  value: state.loginModel.data.token).then((value)
              {
                token=state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
              });
            }
            else
            {
              showToast(
                text: state.loginModel.message,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context,state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key:formKey,
                  child: Column(
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormFeild(
                        controller:nameController,
                        type:TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix:Icons.person,),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormFeild(
                        controller:emailController,
                        type:TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'email must don\'t be empty';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix:Icons.email_outlined,),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormFeild(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: ShopRegisterCubit.get(context).suffix,
                        suffixedpressed:()
                        {
                          ShopRegisterCubit.get(context).changePasswordVisibility();
                        },
                        ispassword: ShopRegisterCubit.get(context).isPassword,
                        validate:  (String value)
                        {
                          if(value.isEmpty)
                          {
                            return 'password must don\'t be empty';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix:Icons.lock,),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormFeild(
                        controller:phoneController,
                        type:TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone must don\'t be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix:Icons.phone,),
                      SizedBox(
                        height: 25,
                      ),
                      ConditionalBuilder(
                        condition:state is! ShopRegisterLoadingState,
                        builder: (context)=>defaultButton(function: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            ShopRegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                          text: 'Register',
                          isUpperCase: true,
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator()),
                      ),
                    ],
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





// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:projects/layout/shop_app/shop_layout.dart';
// import 'package:projects/modules/shop_app/login/cubit/shop_cubit.dart';
// import 'package:projects/modules/shop_app/login/cubit/states.dart';
// import 'package:projects/modules/shop_app/register/cubit/shop_cubit.dart';
// import 'package:projects/modules/shop_app/register/cubit/states.dart';
// import 'package:projects/shared/network/local/cach_helper.dart';
//
// import '../../../components.dart';
// import '../../../constants.dart';
//
// class ShopRegisterScreen extends StatelessWidget {
//   var formKey=GlobalKey<FormState>();
//   var nameController=TextEditingController();
//   var passwordController=TextEditingController();
//   var emailController=TextEditingController();
//   var phoneController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context)=>ShopRegisterCubit(),
//       child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
//         listener: (context,state){
//           if(state is ShopRegisterSuccessState)
//           {
//             if(state.loginModel.status)
//             {
//               print(state.loginModel.message);
//               print(state.loginModel.data.token);
//               CacheHelper.saveData(
//                   key:'token',
//                   value:state.loginModel.data.token).then((value)
//               {
//                 token=state.loginModel.data.token;
//                 navigateAndFinish(
//                     context,
//                     ShopLayout());
//               });
//             }
//             else{
//               print(state.loginModel.message);
//               showToast(
//                 text: state.loginModel.message,
//                 state:ToastStates.ERROR,);
//             }
//           }
//         },
//         builder: (context,state){
//           return Scaffold(
//             appBar: AppBar(),
//             body:Center(
//               child: SingleChildScrollView (
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Form(
//                     key:formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children:[
//                         Text('REGISTER',
//                           style:Theme.of(context).textTheme.headline4.copyWith(
//                             color:Colors.black,
//                           ),
//                         ),
//                         SizedBox(
//                           height:15.0,),
//                         Text(
//                           'REGISter now to browse our hot offers',
//                           style:Theme.of(context).textTheme.bodyText1.copyWith(
//                             color:Colors.grey,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                         defaultFormFeild(
//                           controller: nameController,
//                           type:TextInputType.name,
//                           validate:(String value){
//                             if(value.isEmpty)
//                             {
//                               return'please enter your name';
//                             }
//                           },
//                           label: 'Name',
//                           prefix:Icons.person,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormFeild(
//                           controller: emailController,
//                           type:TextInputType.emailAddress,
//                           validate:(String value){
//                             if(value.isEmpty)
//                             {
//                               return'please enter your email address';
//                             }
//                           },
//                           label: 'Email Address',
//                           prefix:Icons.email_outlined,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormFeild(
//                           controller: passwordController,
//                           type:TextInputType.visiblePassword,
//                           suffix: ShopRegisterCubit.get(context).suffix,
//                           suffixedpressed: (){
//                             ShopRegisterCubit.get(context).changePasswordVisibility();
//                           },
//                           ispassword: ShopRegisterCubit.get(context).isPassword,
//                           onFieldSubmit:(value){
//                             if(formKey.currentState.validate())
//                             {
//                               ShopRegisterCubit.get(context).userRegister(
//                                   name: nameController.text,
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                   phone: phoneController.text
//                               );
//                             }
//                           },
//
//                           validate:(String value){
//                             if(value.isEmpty)
//                             {
//                               return'password is too short';
//                             }
//                           },
//                           label: 'Password',
//                           prefix:Icons.lock_outline,
//                         ),
//                         defaultFormFeild(
//                           controller: phoneController,
//                           type:TextInputType.phone,
//                           validate:(String value){
//                             if(value.isEmpty)
//                             {
//                               return'please enter your phone';
//                             }
//                           },
//                           label: 'Phone',
//                           prefix:Icons.phone,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         ConditionalBuilder(
//                           condition: state is! ShopRegisterLoadingState,
//                           builder:(context)=>defaultButton(
//                             function: (){
//                               if(formKey.currentState.validate())
//                               {
//                                 ShopLoginCubit.get(context).userLogin(
//                                     email: emailController.text,
//                                     password: passwordController.text);
//                               }
//                             },
//                             text: 'Register',
//                             isUpperCase: true,
//                           ),
//                           fallback: (context)=>Center(child: CircularProgressIndicator()),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
