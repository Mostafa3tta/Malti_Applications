import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/shop_app/shop_cubit.dart';
import 'package:projects/layout/shop_app/states.dart';
import 'package:projects/models/shop_app/favorites_model.dart';
import 'package:projects/shared/styles/colors.dart';
class FavoritiesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (contetx,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingFavoritesState,
          builder:(context)=> ListView.separated(
            itemBuilder:(context,index)=>buildFavItem(ShopCubit.get(context).favoritesModel.data.data[index].product,context),
            separatorBuilder:(context,index)=>myDiver() ,
            itemCount:ShopCubit.get(context).favoritesModel.data.data.length,),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );;
  }
  Widget buildFavItem(Product model,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image:NetworkImage(model.image),
                width:120.0,
                height: 120,

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
                      fontSize: 14,
                      height: 1.3
                  ),
                ),
                Spacer(),
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
                        '${model.oldPrice}',

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
    ),
  );
}




// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:projects/layout/shop_app/cubit/shop_cubit.dart';
// import 'package:projects/layout/shop_app/cubit/states.dart';
// import 'package:projects/models/shop_app/favorites_model.dart';
// import 'package:projects/shared/styles/colors.dart';
//
// import '../../../components.dart';
//
// class FavoritiesScreen extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context)  {
//     BlocConsumer<ShopCubit,ShopStates>(
//       listener: (context,state){},
//       builder: (context,state){
//         return ConditionalBuilder(
//           condition: state is! ShopLoadingFavoritesState,
//         builder:(context)=> ListView.separated(
//               itemBuilder: (context,index)=>buildListProduct(ShopCubit.get(context).favoritesModel.data.data[index].product,context),
//               separatorBuilder: (context,index)=>myDiver(),
//               itemCount: ShopCubit.get(context).favoritesModel.data.data.length, ),
//           fallback:(context)=>Center(child: CircularProgressIndicator()),
//         );
//       },
//
//     );
//   }
//
// }
