import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/components.dart';
import 'package:projects/layout/shop_app/shop_cubit.dart';
import 'package:projects/layout/shop_app/states.dart';
import 'package:projects/modules/news_app/search/search_screen.dart';
import 'package:projects/modules/shop_app/login/login_screen.dart';
import 'package:projects/shared/network/local/cach_helper.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('salla'),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search,)),
            ],
          ),

          body:cubit.bottomScreen[cubit.currentIndex] ,
           bottomNavigationBar: BottomNavigationBar(
             onTap: (int index)
             {
               cubit.ChangeBottom(index);
             },
             currentIndex: cubit.currentIndex,
             items: [
               BottomNavigationBarItem(
                   icon:Icon(Icons.home),
                   label: 'Home',
               ) ,
               BottomNavigationBarItem(
                 icon:Icon(Icons.apps,),
                 label: 'Categories',
               ),
               BottomNavigationBarItem(
                 icon:Icon(Icons.favorite,),
                 label: 'Favorite',
               ),
               BottomNavigationBarItem(
                 icon:Icon(Icons.settings),
                 label: 'Settings',
               )
             ],
           ),
        );
      },
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:projects/components.dart';
// import 'package:projects/layout/shop_app/cubit/states.dart';
// import 'package:projects/modules/shop_app/login/login_screen.dart';
// import 'package:projects/modules/shop_app/search/search_screen.dart';
// import 'package:projects/shared/network/local/cach_helper.dart';
//
// import 'cubit/shop_cubit.dart';
//
// class ShopLayout extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit,ShopStates>(
//       listener: (context,state){},
//       builder: (context,state){
//         var cubit=ShopCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(
//             title:Text('Salla'),
//             actions: [
//               IconButton(
//                   onPressed: (){
//                     navigateTo(context, SearchScreen());
//                   },
//                   icon:Icon(Icons.search,))
//                          ],
//           ),
//           body:cubit.bottomScreen[cubit.currentIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             onTap:(int index)
//             {
//               cubit.ChangeBottom(index);
//             },
//             currentIndex: cubit.currentIndex,
//             items: [
//               BottomNavigationBarItem(
//                   icon:Icon(Icons.home,),
//                 label:'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon:Icon(Icons.apps,),
//                 label:'Categories',
//               ),
//               BottomNavigationBarItem(
//                 icon:Icon(Icons.favorite,),
//                 label:'Favorites',
//               ),
//               BottomNavigationBarItem(
//                 icon:Icon(Icons.settings,),
//                 label:'Settings',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
