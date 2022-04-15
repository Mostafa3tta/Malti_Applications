import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:projects/components.dart';
class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  bool isPassword =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child:Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Login',
                    style:TextStyle(
                      fontSize: 30.0,
                      color:Colors.black,
                    ),
                  ),
                  SizedBox(
                      height: 20,),
                  defaultFormFeild(
                    controller: emailController,
                    label: 'Email',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validate:(value){
                     if(value.isEmpty){
                      return 'email address must not be empty';
                     }
                     return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormFeild(
                    controller: passwordController,
                    label: 'Password',
                    prefix: Icons.lock,
                    suffix:!isPassword?Icons.visibility:Icons.visibility_off,
                    ispassword: isPassword,
                    suffixedpressed: (){
                      setState(() {
                        isPassword=!isPassword;
                      });
                    },
                    type: TextInputType.visiblePassword,
                    validate:(value){
                      if(value.isEmpty){
                        return 'password must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                 defaultButton(
                   text: 'login',
                  // isUpperCase:false,
                   function:(){
                     if(formKey.currentState!.validate()) {
                       print(emailController.text);
                       print(passwordController.text);
                     }
                   },

                 ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text('Don\'t have account?'),
                      TextButton(onPressed: (){},
                          child: Text('Register Now'),),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
