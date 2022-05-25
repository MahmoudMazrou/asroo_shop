
import 'package:asroo_shop/asroo_layout.dart';
import 'package:asroo_shop/firebase_options.dart';
import 'package:asroo_shop/modules/register_screen/register_screen.dart';
import 'package:asroo_shop/shared/applocal.dart';
import 'package:asroo_shop/shared/bloc_observer.dart';
import 'package:asroo_shop/shared/components/constants.dart';
import 'package:asroo_shop/shared/cubit/cubit.dart';
import 'package:asroo_shop/shared/cubit/states.dart';
import 'package:asroo_shop/shared/network/local/cache_helper.dart';
import 'package:asroo_shop/shared/network/remote/dio_helper.dart';
import 'package:asroo_shop/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'modules/splash_screen/splash_screen.dart';


void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key:'isDark');
  print(isDark!);
  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');//هاي قيمة تعت البيج فيو الان بوردينق  عشان اذا مخزن قيمة تروحش الها مرة ثانية
 // token = CacheHelper.getData(key: 'token');
  //print(token!);
  //
  // if(onBoarding != null)
  // {
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // } else
  // {
  //   widget = OnBoardingScreen();
  // }
  widget =SplashScreen();
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build
   bool? isDark;
  Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

   @override
   Widget build(BuildContext context) {
     return MultiBlocProvider(
       providers: [
         BlocProvider(
           create: (BuildContext context) => AppCubit()
           ..changeAppModeStart(fromShared: isDark!),),

       ],

       child: BlocConsumer<AppCubit,AppStates>(
           listener: ( context, state) {} ,
           builder: ( context, state) {

             return  MaterialApp(
               debugShowCheckedModeBanner: false,
               theme: lightTheme,
               darkTheme: darkTheme,
               themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
               // ##localizations
               supportedLocales: const [ //اللغات الي التطبيق هيدعمها
                 Locale("en","US"),
                 Locale("ar","PS")
               ],
               localizationsDelegates: const [
                 AppLocale.delegate,                 //هاد لكلاس تبعنا
                 GlobalMaterialLocalizations.delegate,
                 GlobalWidgetsLocalizations.delegate
               ],
               locale:Locale ("en",""),  //اجبر التطبيق يشتغل بلغة الانجليزية مثلا
               localeResolutionCallback: (currentLang, supportLang) {
                 if (currentLang != null) {
                   for (Locale locale in supportLang) {
                     if (locale.languageCode == currentLang.languageCode) {
                  //     SharedPreferences.setString("lang",currentLang.languageCode) ;
                       return currentLang;
                     }
                   }
                 }
                 return supportLang.first;
               },

               home: SplashScreen(),
             );
           }

       ),
     );
   }
}
