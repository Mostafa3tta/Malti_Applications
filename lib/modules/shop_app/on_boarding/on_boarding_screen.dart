import 'package:flutter/material.dart';
import 'package:projects/components.dart';
import 'package:projects/modules/shop_app/login/login_screen.dart';
import 'package:projects/shared/network/local/cach_helper.dart';
import 'package:projects/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel{
  late  String image;
  late  String title;
  late  String body;
  BoardingModel({
    required  this.image,
    required this.title,
    required  this.body,
});
}
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();
  bool isLast=false;
List<BoardingModel>boarding=[
  BoardingModel(
    image:'assets/images/onboard_1.jpg',
    title:'on Boarding 1 title',
    body:'on Boarding 1 body',
  ),
  BoardingModel(
    image:'assets/images/onboard_1.jpg',
    title:'on Boarding 2 title',
    body:'on Boarding 2 body',
  ),
  BoardingModel(
    image:'assets/images/onboard_1.jpg',
    title:'on Boarding 3 title',
    body:'on Boarding 3 body',
  ),
];
 void  submit()
 {
   CacheHelper.saveData(
     key: 'onBoarding',
     value: true,).then((value)
   {
     navigateAndFinish(context,ShopLoginScreen());
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
              {
               submit();
              },
              child:Text('SKIP',),)
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (int index)
                  {
                    if(index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }
                    else
                      {
                        setState(() {
                          isLast=false;
                        });
                      }
                  },
                  itemBuilder: (context,index)=>builtBoardingItem(boarding[index]),
                 itemCount:boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      dotColor: Colors.grey,
                      spacing: 5,
                      expansionFactor: 4,
                      activeDotColor: defaultColor,
                    ),
                    count: boarding.length,),
                Spacer(),
                FloatingActionButton(
                    onPressed:()
                    {
                      if(isLast)
                      {
                      submit();
                      }
                      else{
                        boardController.nextPage(duration:Duration(
                          milliseconds: 750,
                        ), curve:Curves.fastLinearToSlowEaseIn,);
                      }
                    },
                child:Icon(Icons.arrow_forward_ios,),),
              ],
            ),
          ],
        ),
      ),
    );
  }

 Widget builtBoardingItem(BoardingModel model)=>Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
     Expanded(
       child: Image(
         image:AssetImage('${model.image}'),
       ),
     ),
     SizedBox(
       height: 40,
     ),
     Text('${model.title}',
       style:TextStyle(
         fontSize:24,
         fontWeight:FontWeight.bold,
       ),
     ),
     SizedBox(
       height: 10,
     ),
     Text('${model.body}',
       style:TextStyle(
         fontSize:14,
         fontWeight:FontWeight.bold,
       ),),
     SizedBox(
       height: 10,
     ),
   ],
 );
}



// import 'package:flutter/material.dart';
// import 'package:projects/components.dart';
// import 'package:projects/modules/shop_app/login/login_screen.dart';
// import 'package:projects/shared/network/local/cach_helper.dart';
// import 'package:projects/shared/network/remote/dio_helper.dart';
// import 'package:projects/shared/styles/colors.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// class BoardingModel{
//   final String image;
//   final String title;
//   final String body;
//   BoardingModel({
//   @required this.image,
//     @required this.title,
//   @required this.body});
// }
// class OnBoardingScreen extends StatefulWidget {
//   @override
//   _OnBoardingScreenState createState() => _OnBoardingScreenState();
// }
//
// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   var boardController=PageController();
//   bool isLast=false;
// List<BoardingModel>boarding=[
//   BoardingModel(
//       image:'assets/images/onboard_1.jpg',
//       title:'On Board 1 title',
//       body: 'On Board 1 body'),
//   BoardingModel(
//       image:'assets/images/onboard_1.jpg',
//       title:'On Board 2 title',
//       body: 'On Board 2 body'),
//   BoardingModel(
//       image:'assets/images/onboard_1.jpg',
//       title:'On Board 3 title',
//       body: 'On Board 3 body'),
//
// ];
//  void  submit()
//  {
//    CacheHelper.saveData(
//        key:'onBoarding',
//        value:true).then((value)
//    {
//      navigateAndFinish(context, ShopLoginScreen());
//    });
//
//  }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           TextButton(
//               onPressed:(){
//                 submit();
//               },
//               child:Text('SKIP'),)
//         ],
//       ),
//       body:Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           children: [
//            Expanded(
//              child: PageView.builder(
//                  physics: BouncingScrollPhysics(),
//                  onPageChanged:(int index)
//                  {
//                    if(index==boarding.length-1)
//                    {
//                      setState(() {
//                        isLast=true;
//                      });
//                    }
//                    else{
//                      setState(() {
//                        isLast=false;
//                      });
//                    }
//                  },
//                  controller:boardController,
//                  itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
//                  itemCount:boarding.length,),
//            ),
//             SizedBox(
//               height: 40.0,
//             ),
//             Row(
//               children: [
//                 SmoothPageIndicator(
//                     controller:boardController,
//                     effect: ExpandingDotsEffect(
//                       dotColor: Colors.grey,
//                       dotHeight: 10,
//                       dotWidth: 10,
//                       spacing: 5,
//                       activeDotColor: defaultColor,
//                       expansionFactor: 4,
//                     ),
//                     count: boarding.length),
//                 Spacer(),
//                 FloatingActionButton(
//                   onPressed: (){
//                     if(isLast==true)
//                     {
//                       submit();
//                     }
//                     else
//                       {
//                         boardController.nextPage(
//                           duration: Duration(
//                             milliseconds: 750,
//                           ),
//                           curve:Curves.fastLinearToSlowEaseIn,
//                         );
//                     }
//
//                   },
//                   child: Icon(
//                       Icons.arrow_forward_ios,),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildBoardingItem(BoardingModel model)=>Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Expanded(
//         child: Image(
//             image:AssetImage('${model.image}')),
//       ),
//       SizedBox(
//         height: 30.0,
//       ),
//       Text(
//         '${model.title}',
//         style:TextStyle(
//           fontSize: 24.0,
//           fontWeight: FontWeight.bold,
//         ),),
//       SizedBox(
//         height: 15.0,
//       ),
//       Text(
//         '${model.body}',
//         style:TextStyle(
//           fontSize: 14.0,
//           fontWeight: FontWeight.bold,
//         ),),
//       SizedBox(
//         height: 15.0,
//       ),
//     ],
//   );
// }
