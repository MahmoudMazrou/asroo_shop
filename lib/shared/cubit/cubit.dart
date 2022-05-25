import 'package:asroo_shop/modules/home_screen/home_screen.dart';
import 'package:asroo_shop/modules/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asroo_shop/shared/cubit/states.dart';
import 'package:asroo_shop/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    SettingsScreen(),

  ];

  List<String> titles = [
    "HomeScreen",
    'setting',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }


  bool isDark = false;
  void changeAppModeStart({bool? fromShared})
  {
    if (fromShared!)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
  }
  void changeAppMode()
  {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });

  }
}
