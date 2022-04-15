import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/constants.dart';
import 'package:projects/layout/shop_app/shop_cubit.dart';
import 'package:projects/layout/shop_app/states.dart';
import 'package:projects/modules/shop_app/login/login_screen.dart';
class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
var nameController=TextEditingController();
var emailController=TextEditingController();
var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var model=ShopCubit.get(context).userModel;
        nameController.text=model.data.name;
        emailController.text=model.data.email;
        phoneController.text=model.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel!=null,
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(

                children: [
                  if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                   SizedBox(
                   height: 20,
                   ),
                  defaultFormFeild(
                    controller:nameController,
                    type:TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must don\'t be empty';
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
                  defaultButton(
                      function: ()
                      {
                        if(formKey.currentState!.validate()){
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,);
                        }

                      },
                      text:'Update' ),
                  SizedBox(
                    height: 25,
                  ),
                  defaultButton(
                      function: ()
                      {
                        signOut(context);//ShopLoginScreen());
                      },
                      text:'logout' ),
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}







// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:projects/components.dart';
// import 'package:projects/layout/shop_app/cubit/shop_cubit.dart';
// import 'package:projects/layout/shop_app/cubit/states.dart';
//
// import '../../../constants.dart';
//
// class SettingsScreen extends StatelessWidget {
//    var formKey=GlobalKey<FormState>();
//   var nameController=TextEditingController();
//   var emailController=TextEditingController();
//   var phoneController=TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit,ShopStates>(
//        listener: (context,state) {},
//       builder:(context,state){
//          var model=ShopCubit.get(context).userModel;
//          nameController.text= model.data.name;
//          emailController.text= model.data.email;
//          phoneController.text= model.data.phone;
//          return ConditionalBuilder(
//            condition:ShopCubit.get(context).userModel!=null,
//            builder:(context)=> Padding(
//              padding: const EdgeInsets.all(20.0),
//              child: Form(
//                key:formKey,
//                child: SingleChildScrollView(
//                  child: Column
//                    (
//                    children: [
//                      if(state is ShopLoadingUpdateUserState)
//                        LinearProgressIndicator(),
//                      SizedBox(height: 20.0,),
//                      defaultFormFeild(
//                        controller:nameController,
//                        type:TextInputType.name,
//                        validate:(String value)
//                        {
//                          if(value.isEmpty)
//                          {
//                            return 'name must don\'t be empty';
//                          }
//                          return null;
//                        },
//                        label: 'Name',
//                        prefix: Icons.person,
//                      ),
//
//                      SizedBox(
//                        height: 20.0,
//                      ),
//                      defaultFormFeild(
//                        controller:emailController,
//                        type:TextInputType.emailAddress,
//                        validate:(String value)
//                        {
//                          if(value.isEmpty)
//                          {
//                            return 'email must d\'ont be empty';
//                          }
//                          return null;
//                        },
//                        label: 'Email Address',
//                        prefix: Icons.email,
//                      ),
//                      SizedBox(
//                        height: 20.0,
//                      ),
//                      defaultFormFeild(
//                        controller:phoneController,
//                        type:TextInputType.phone,
//                        validate:(String value)
//                        {
//                          if(value.isEmpty)
//                          {
//                            return 'phone must don\'t be empty';
//                          }
//                          return null;
//                        },
//                        label: 'Phone',
//                        prefix: Icons.phone,
//                      ),
//                      SizedBox(
//                        height: 15.0,
//                      ),
//                      defaultButton(
//                          function: ()
//                          {
//                            if(formKey.currentState.validate())
//                            {
//                              ShopCubit.get(context).updateUserData(
//                                name: nameController.text,
//                                email: emailController.text,
//                                phone: phoneController.text,
//
//
//                              );
//                            }
//
//                          },
//                          text:'Update'
//                      ),
//                      SizedBox(
//                        height: 20.0,
//                      ),
//                     defaultButton(
//                         function: ()
//                         {
//                           signOut(context);
//                         },
//                         text:'LogOut'
//                     ),
//
//                    ],
//                  ),
//                ),
//              ),
//            ),
//            fallback: (context)=>Center(child: CircularProgressIndicator()),
//          );
//       } ,
//     );
//   }
// }
