
import 'package:asroo_shop/models/app_user_model.dart';
import 'package:asroo_shop/modules/register_screen/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterInitialState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);
  void _showErrorDialog(String message,BuildContext context){
    showDialog(
      context: context,
      builder: (ctx)=>AlertDialog(
        title: Text("an Error Occurred!"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text("OKay"),
            onPressed: (){
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),

    );
  }


  void userRegister({//الأشياء الي بنسجل فيها
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) {

    emit(AppRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(//المثود الخاصة بتسجيل الدخول  مع الاميل ولباسوورد صريييحة
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(   //لمن ينجح التسجيل عبي اليوزر
          uId: value.user!.uid,
          email: email,
          name: name,
      );
    }).catchError((error) {

      _showErrorDialog("${error.message}",context);
      // print('Failed with error code: ${error.code}');
      // print(error.message);
      emit(AppRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
  }) {
    AppUserModel model = AppUserModel( //هاد الموديل اوالكونستركتور  يعني
      name: name,
      email: email,
      uId: uId,
      image: 'https://image.freepik.com/free-photo/photo-attractive-bearded-young-man-with-cherful-expression-makes-okay-gesture-with-both-hands-likes-something-dressed-red-casual-t-shirt-poses-against-white-wall-gestures-indoor_273609-16239.jpg',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')//لو في users بيدخل فيها لو مفيش بكريتها
        .doc(uId)//الدوكيومنت بسميها ب يوزر اي دي افضل شي لانو تلقائي
        .set(model.toMap())//بنبعت المودل ك ماب طبعا
        .then((value)
    {
   //   print("ok");
      emit(AppCreateUserSuccessState(uId));
    })
        .catchError((error) {
   //   print(error.toString());
      emit(AppCreateUserErrorState(error.toString()));
    });
  }
  Widget chekImage = Container();
  bool isChekImage= true;

  void changeChicPoxImage() {
    isChekImage = !isChekImage;
    chekImage = isChekImage? Container() : Image.asset("assets/images/check.png");

    emit(AppRegisterChangeChicPoxImageState());
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppRegisterChangePasswordVisibilityState());
  }
}