import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/shop_app/shop_cubit.dart';
import 'package:projects/layout/shop_app/states.dart';
import 'package:projects/models/shop_app/categories_model.dart';
import 'package:projects/models/shop_app/home_model.dart';
import 'package:projects/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopSuccessChangeFavoritesState)
        {
          if(state.model.status)
          {
            showToast(
                text: state.model.message,
                state:ToastState.ERROR);
          }
        }
      },
      builder: (context,state)
      {
        return ConditionalBuilder(
             condition:state is! ShopLoadingHomeDataState &&state is! ShopLoadingCategoriesState,
              builder: (context)=>ProductsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
             fallback: (context)=>Center(child: CircularProgressIndicator()),
         );
      },
    );
  }

  Widget ProductsBuilder(HomeModel model, CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics:BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       CarouselSlider(
         items:model.data.banners.map((e) => Image(
         image:NetworkImage('${e.image}'),
         width: double.infinity,
         fit: BoxFit.cover,
    ),).toList(),
           options: CarouselOptions(
             height: 250.0,
             initialPage: 0,
             reverse: false,
             enableInfiniteScroll: true,
             viewportFraction: 1,
             autoPlayAnimationDuration:Duration(seconds:1),
             autoPlayCurve: Curves.fastOutSlowIn,
             autoPlay: true,
             autoPlayInterval: Duration(seconds:3),
             scrollDirection: Axis.horizontal,

           ),),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics:BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=> buildCategoryItem( categoriesModel.data.data[index]),
                    separatorBuilder:(context,index)=>SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoriesModel.data.data.length),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color:Colors.white,
          child: GridView.count(

             shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
               crossAxisCount:2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.70,

            children:List.generate(
                  model.data.products.length, (index) =>buildGridProduct(model.data.products[index],context) ),
          ),
        )
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:[
      Image(
        image:NetworkImage(model.image),
        height: 100,
        width:100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8,),
        width: 100,
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style:TextStyle(
            color:Colors.white,
          ),
        ),
      ),
    ],
  );
  Widget buildGridProduct(ProductModel  model,context)=>Container(
    color:Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage(model.image),
              width: double.infinity,
              height: 200,
            ),
            if(model.discount !=0)
            Container(
              color:Colors.red,
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
              ),
              child:Text(
                  'DISCOUNT',
              style:TextStyle(
                fontSize: 8,
                color:Colors.white,
              ),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price}',

                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount !=0)
                  Text(
                    '${model.old_price}',

                    style: TextStyle(
                      fontSize: 10,
                      color:Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    
                      onPressed:(){
                        ShopCubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      },
                    icon:CircleAvatar(
                      radius: 15.0,
                      backgroundColor:ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey,
                      child: Icon(
                      Icons.favorite_border,
                      size:12,
                      color:Colors.white,
                  ),
                    ),)
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:projects/components.dart';
// import 'package:projects/constants.dart';
// import 'package:projects/layout/news_app/cubit/shop_cubit.dart';
// import 'package:projects/layout/shop_app/cubit/shop_cubit.dart';
// import 'package:projects/layout/shop_app/cubit/states.dart';
// import 'package:projects/models/shop_app/categories_model.dart';
// import 'package:projects/models/shop_app/home_model.dart';
// import 'package:projects/shared/styles/colors.dart';
//
//
// class ProductsScreen extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit,ShopStates>(
//       listener: (context,state)
//       {
//         if (state is ShopSuccessChangeFavoritesState) {
//           if (!state.model.status) {
//             showToast(
//               text: state.model.message,
//               state: ToastStates.ERROR,
//             );
//           }
//         }
//       },
//       builder:(context,state){
//         return ConditionalBuilder(
//             condition: ShopCubit.get(context).homeModel !=null&&ShopCubit.get(context).cateogriesModel !=null,
//             builder: (context)=>productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).cateogriesModel,context),
//            fallback:(context)=> Center(child: CircularProgressIndicator()),
//         );
//       } ,
//     );
//
//   }
//
//   Widget productsBuilder(HomeModel model,CategoriesModel  categoriesModel,context)=>SingleChildScrollView(
//     physics: BouncingScrollPhysics(),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//         CarouselSlider(
//             items:model.data.banners.map((e) =>
//               Image(
//                 image:NetworkImage('${e.image}'),
//                 width: double.infinity,
//                 fit:BoxFit.cover,
//               ),
//             ).toList(),
//             options: CarouselOptions(
//               height: 250,
//               initialPage: 0,
//               enableInfiniteScroll: true,
//               viewportFraction: 1.0,
//               reverse: false,
//               autoPlay: true,
//               autoPlayInterval: Duration(seconds: 3),
//               autoPlayAnimationDuration: Duration(seconds: 1),
//               autoPlayCurve: Curves.fastOutSlowIn,
//               scrollDirection: Axis.hor nizontal,
//             ),
//         ),
//         SizedBox(
//           height: 10.0,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 10,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                   'Categories',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//            SizedBox(height: 10.0,),
//        Container(
//                height: 100.0,
//                child: ListView.separated(
//                    physics:BouncingScrollPhysics() ,
//                    scrollDirection: Axis.horizontal,
//                    itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data.data[index]),
//                    separatorBuilder: (context,index)=>SizedBox(width:10.0,),
//                    itemCount:categoriesModel.data.data.length,),
//        ),
//               SizedBox(height: 20,),
//               Text(
//                 'New Products',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           color:Colors.grey[300],
//           child: GridView.count(
//                shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               crossAxisCount:2,
//               mainAxisSpacing:1.0,
//               crossAxisSpacing:1.0,
//               childAspectRatio: 1/1.58,
//           children:List.generate(
//               model.data.products.length,
//               (index) =>buildGridProduct(model.data.products[index],context),
//           ),),
//         )
//       ],
//     ),
//   );
//   Widget buildCategoryItem(DataModel model)=> Stack(
//     alignment: AlignmentDirectional.bottomCenter,
//     children: [
//       Image(
//         image:NetworkImage(model.image),
//         height: 100.0,
//         width: 100.0,
//         fit: BoxFit.cover,
//       ),
//       Container(
//         color:Colors.black.withOpacity(.8,),
//         child: Text(
//           model.name,
//           textAlign: TextAlign.center,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style:TextStyle(
//             color:Colors.white,
//           ),
//         ),
//       ),
//     ],
//   );
//   Widget buildGridProduct(ProductModel model,context)=>Container(
//     color:Colors.white,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(
//           alignment: AlignmentDirectional.bottomStart,
//           children: [
//             Image(
//               image:NetworkImage(model.image),
//               width: 150,
//               height: 150,
//               fit:BoxFit.cover,
//             ),
//             if(model.discount!=0)
//             Container(
//               color:Colors.red,
//               padding:EdgeInsets.symmetric(horizontal: 5.0,) ,
//               child: Text(
//                 'DISCOUNT',
//                 style: TextStyle(
//                   fontSize: 8.0,
//                   color:Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 model.name,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   height: 1.3,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     '${model.price} ',
//
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: defaultColor,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5.0,
//                   ),
//                   if(model.discount!=0)
//                   Text(
//                     '${model.oldPrice} ',
//
//                     style: TextStyle(
//                       fontSize: 10,
//                       color:Colors.grey,
//                       decoration: TextDecoration.lineThrough,
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//
//                     onPressed: () {
//                       ShopCubit.get(context).changeFavorites(model.id);
//                       print(model.id);
//                     },
//                       icon: CircleAvatar(
//                         radius: 15.0,
//                         backgroundColor:ShopCubit.get(context).favorites[model.id]?defaultColor:Colors.grey,
//                         child: Icon(
//                           Icons.favorite_border,
//                           size:14.0,
//                           color: Colors.white,
//                         ),
//                       ),)
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
