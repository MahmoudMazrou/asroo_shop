abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppDeleteDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class AppChangeModeState extends AppStates {}


//**//
class AppGetFavouriteLoadingState extends AppStates {}
class AppGetFavouriteSuccessState extends AppStates {}
class AppGetFavouriteErrorState extends AppStates {
  AppGetFavouriteErrorState(String string);
}

//addFavorite
class AppaddFavouriteLoadingState extends AppStates {}
class AppaddFavouriteSuccessState extends AppStates {}
class AppaddFavouriteErrorState extends AppStates {
  AppaddFavouriteErrorState(String string);
}



class AppLoadingGetFavoritesState extends AppStates {}



class AppSuccessGetProductsState extends AppStates {}
class AppEroorGetProductsState extends AppStates {}
class AppLoadingGetProductsState extends AppStates {}





