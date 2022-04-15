
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projects/layout/shop_app/shop_cubit.dart';
import 'package:projects/models/shop_app/favorites_model.dart';
import 'package:projects/shared/styles/colors.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'modules/news_app/web_view/web_view_screen.dart';


Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  bool isUpperCase=true,
  double radius=3.0,
 required Function function,
 required String text,

})=>Container(
  width:width,
  height: 40.0,
  child: MaterialButton(
    onPressed:()
    {
      function();
    },
    child:
    Text(
      isUpperCase?text.toUpperCase():text,
      style:TextStyle(
        color: Colors.white,
      ),),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color:background,
  ),
);
Widget defaultTextButton({
    required Function function,
    required String text,

})=>
  TextButton(
    onPressed:()
    {
      function();
    },
    child: Text(
    text.toUpperCase(),
),
  );

Widget defaultFormFeild({
  required TextEditingController controller,
  required  TextInputType type,
   Function ?onFieldSubmit,
   Function ?onChange,
   Function ?onTap,
  bool ispassword=false,
  required Function validate,
  required String label,
  required  IconData prefix,
   IconData ?suffix,
   Function  ?suffixedpressed,

})=> TextFormField(
controller: controller,
obscureText:ispassword,
keyboardType:type,
onFieldSubmitted:(s)
{
  onFieldSubmit!(s);
} ,
onChanged: (s)
{
  onChange!(s);
},
onTap: ()
{
  onTap!();
},
validator:(s)
{
  validate(s);
},
decoration: InputDecoration(
labelText:label ,
border:OutlineInputBorder(),

prefix:Icon(
    prefix,),
suffix:suffix!=null? IconButton(onPressed:(){
  suffixedpressed!();
},
icon:Icon(
suffix,),
):null,
),
);
Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?actions,
})=> AppBar(
  leading: IconButton(
    onPressed:()
    {
      Navigator.pop(context);
    },
    icon:Icon(
    Icons.arrow_left,
  ),
  ),
  title: Text(
    title!,
  ),
  actions:actions,
);

Widget buildTasksItem(Map model)=>Padding(
padding: const EdgeInsets.all(20.0),
child: Row(
children: [
CircleAvatar(
radius: 35.0,
child: Text(
'${model['time']}',
),
),
SizedBox(
width: 20.0,
),
Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('${model['title']}',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),),
          Text('${model['date']}',
            style: TextStyle(
              color:Colors.grey ,
            ),)
        ],
      ),
    ],
  ),
);

Widget BuildArticleItem(article,context,index)=>Container(
  color:NewsCubit.get(context).selectBusinessItem==index?Colors.grey[200]:null,
  child:   InkWell(
    onTap: (){
      //navigateTo(context, widget)
      NewsCubit.get(context).selectedBusinessItem(index);
    },
    child:   Padding(

      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(10.0),
              image: DecorationImage(
                image:NetworkImage('${article['urlToImage']}'),
                fit:BoxFit.cover,
              ),

            ),

          ),

          SizedBox(

            width: 10.0,

          ),

          Expanded(

            child: Container(

              height: 120.0,

              child: Column(

                mainAxisAlignment:MainAxisAlignment.start,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Expanded(

                    child: Text('${article['title']}',

                      style:Theme.of(context).textTheme.bodyText1,

                      maxLines: 3,

                      overflow:TextOverflow.ellipsis,),

                  ),

                  Text('${article['publishedAt']}',

                    style:TextStyle(

                      color:Colors.grey,

                    ),)

                ],

              ),

            ),



          ),



        ],

      ),

    ),
  ),
);

Widget myDiver()=> Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color:Colors.grey[300],
      ),
    );

Widget articleBuilder(list,{isSearch=false})=>ConditionalBuilder(
  condition:list.length>0,
  builder:(context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder:(context,index)=>BuildArticleItem(list[index],context,index),
    separatorBuilder:(context,index)=>myDiver(),
    itemCount: 10,),
  fallback:(context)=>isSearch?Container():Center(child: CircularProgressIndicator()),
);

void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder:(context)=>widget));

void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget,),
        (route) => false,);

 void showToast(
{
  required String text,
  required ToastState state,
})
 {
   Fluttertoast.showToast(
       msg: text,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 5,
       backgroundColor: Colors.red,
       textColor: Colors.white,
       fontSize: 16.0
   );

 }
 enum ToastState{SUCCESS,ERROR,WARNING}

 Color chooseToastColor(ToastState state)
 {
   Color color;
   switch(state){
     case ToastState.SUCCESS:
       color=Colors.green;
       break;
     case ToastState.ERROR:
       color=Colors.red;
       break;
     case ToastState.WARNING:
       color=Colors.amber;
       break;}
    return color;
 }
// void showToast({
//   @required String text,
//   @required ToastStates state,
//     })=>  Fluttertoast.showToast(
//   msg:text,
//   toastLength: Toast.LENGTH_LONG,
//   gravity: ToastGravity.BOTTOM,
//   timeInSecForIosWeb: 5,
//   backgroundColor:chooseToastColor(state),
//   textColor: Colors.white,
//   fontSize: 16.0,
// );
//
// enum ToastStates{SUCCESS,ERROR,WARNING}
// Color chooseToastColor(ToastStates state)
// {
//  Color color;
//   switch(state)
//   {
//     case ToastStates.SUCCESS:
//       color=Colors.green;
//       break;
//     case ToastStates. ERROR:
//       color=Colors.red;
//       break;
//     case ToastStates.WARNING:
//       color=Colors.amber;
//       break;
//   }
//   return color;
// }
Widget buildListProduct( model,context,{bool isOldPrice=true,})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage(model.image,),
              width: 120,
              height: 120,
              fit:BoxFit.cover,
            ),
            if(model.product.discount!=0&&isOldPrice)
              Container(
                color:Colors.red,
                padding:EdgeInsets.symmetric(horizontal: 5.0,) ,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color:Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),

                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount!=0&&isOldPrice)
                    Text(
                      model.oldPrice.toString(),

                      style: TextStyle(
                        fontSize: 10,
                        color:Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(

                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:ShopCubit.get(context).favorites[model.id]!?Colors.red:Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size:14.0,
                        color: Colors.white,
                      ),
                    ),)
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
