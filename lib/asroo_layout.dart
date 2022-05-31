
import 'package:asroo_shop/shared/cubit/cubit.dart';
import 'package:asroo_shop/shared/styles/icon_broken.dart';
import 'package:asroo_shop/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Asroolayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // if (state is SocialNewPostState) {//اذ هاي لستيت اشتغلت اففتح ل النيو بوست فوق بصفحة جديدة مش زي الباقي بنفس الصفحة
        //   navigateTo(
        //     context,
        //     NewPostScreen(),
        //   );
        // }
      },
      builder: (context, state)
      {
        var cubit = AppCubit.get(context);


        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex], //اعطيتو من لستة عشان يتغير كل منغير بلبوتم شي
              style: const TextStyle(
                fontFamily: 'Circe',
                fontSize: 20,
                color: Color(0xfff5f5f5),
              ),
            ),
            centerTitle: true,

          ),


          body: cubit.screens[cubit.currentIndex],//كل سكرن هتوخد من ليستا برضو
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(4, 6),
                  blurRadius: 12,
                ),
              ],
              ),
              child: BottomNavigationBar(// تنساش انو في ستايل احنا حطينو ب التيم
                currentIndex: cubit.currentIndex,
                onTap: (index)
                {
                  cubit.changeIndex(index);// بستدعيها عند الضغط من الكيوبت وطبعا ستيت منجمنت بلوك
                },
                items:  const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Home,
                    ),
                    label: 'HomeScreen',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Setting,
                    ),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}