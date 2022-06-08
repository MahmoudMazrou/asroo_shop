

import 'package:asroo_shop/models/app_user_model.dart';
import 'package:asroo_shop/modules/favourite_screen/favourite_screen.dart';
import 'package:asroo_shop/modules/home_screen/home_screen.dart';
import 'package:asroo_shop/modules/settings_screen/settings_screen.dart';
import 'package:asroo_shop/shared/network/end_points.dart';
import 'package:asroo_shop/shared/network/remote/dio_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asroo_shop/shared/cubit/states.dart';
import 'package:asroo_shop/shared/network/local/cache_helper.dart';

import '../../models/prodect_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  AppUserModel? userModel;
  var uId = CacheHelper.getData(key: 'uId');

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    "Asroo Shop",
    "Favourite",
    'setting',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<dynamic>? prodect;
  void getProdects() {
    emit(AppLoadingGetProductsState());

    DioHelper.getData(
      url: PRODUCTS,
      // token: token,
    ).then((value) {
      // printFullText(value.data.toString());
      prodect = value.data;
          prodect!.forEach((element) {
        //    print(element["id"]);


          });

      //  printFullText(value.data[0].toString());
      print("555555555secsses55555555");

      emit(AppSuccessGetProductsState());
    }).catchError((error) {
      print("5555" +
          error.toString() +
          "212121212121212222222222222222222222222222222222eror");
      emit(AppEroorGetProductsState());
    });
  }


  List<int> idFavourite =[] ;

  void getFavourite(){
    print("ماذاااا$uId");
    emit(AppGetFavouriteLoadingState());
    FirebaseFirestore.instance.collection('favourite').doc(uId).get().then((value) {
      print("***${value['idFavourite']}");
   var list  =  value['idFavourite'];
   list.forEach((value){
     print(value);
     idFavourite.add(value);
   });

     emit(AppGetFavouriteSuccessState());
    }).catchError((error) {
   //   print(error.toString());
      emit(AppGetFavouriteErrorState(error.toString()));
    });
  }
  bool isFavourite(int id) {
    if (idFavourite.contains(id)) {
      return false ;
    } else {
      return true;
    }

  }


  void addOrRemoveFavourite(int id ){
    emit(AppaddFavouriteLoadingState());

    if(idFavourite.contains(id)){
      idFavourite.remove(id);
      print(uId);
      FirebaseFirestore.instance
            .collection('favourite')
            .doc(uId)
            .set({
          'idFavourite':idFavourite,
        }).then((value) {
          emit(AppaddFavouriteSuccessState());
        }).catchError((error) {
        idFavourite.add(id);
        emit(AppaddFavouriteErrorState(error.toString()));
        });

     //  isFavourite = true;
    }else{
      idFavourite.add(id);
      FirebaseFirestore.instance
          .collection('favourite')
      //معناها جوا البوست نفسو اعمل كوليكشن تاني غير البوست للايك
          .doc(uId)
          .set({
        'idFavourite': idFavourite,
      }).then((value) {
        emit(AppaddFavouriteSuccessState());
      }).catchError((error) {
        idFavourite.remove(id);
        emit(AppaddFavouriteErrorState(error.toString()));
      });
    //   isFavourite = false;
    }

  //  iconFavourite = isFavourite ? Icon(Icons.favorite_border): Icon(Icons.favorite,color: Colors.red,);
    print(idFavourite);
  }

  //firebase



  bool isDark = false;

  void changeAppModeStart({bool? fromShared}) {
    if (fromShared!) {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
  }

  void changeAppMode() {
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });
  }
}
