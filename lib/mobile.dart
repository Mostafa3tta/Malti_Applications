import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive_indicator.dart';

class MobileScreen extends StatelessWidget {

  String osPlatform=Platform.operatingSystem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Expanded(
            child: Container(
              width:double.infinity,
              color:Colors.teal,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login with a account',
                    style:Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color:Colors.teal,
                          height: 45,
                          child: MaterialButton(
                            onPressed: (){},

                            child: Text('LOGIN',
                              style:TextStyle(
                                color:Colors.white,
                              ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          color:Colors.blue,
                          height: 45,
                          child: MaterialButton(
                            onPressed: (){},

                            child: Text('REGISTER',
                              style:TextStyle(
                                color:Colors.white,
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AdaptiveIndicator(
                    os:Platform.operatingSystem,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

