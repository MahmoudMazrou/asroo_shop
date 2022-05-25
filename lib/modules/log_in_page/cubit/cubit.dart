import 'package:asroo_shop/modules/log_in_page/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);
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

  void userLogin(
     String email,
     String password,
     BuildContext context,

  ) {
    emit(AppLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(// واضحة وصريحة
      email: email,
      password: password,
    )
        .then((value) {
      // print(value.user?.email);
      // print(value.user?.uid);


      emit(AppLoginSuccessState(value.user!.uid));//ببعت  معها اليوزر اي دي المسجل عشان استقبلو
    }).catchError((error)
    {
   //   print(error);
      _showErrorDialog("${error.message}",context);


      emit(AppLoginErrorState(error.toString()));
    });
  }







  Widget chekImage = Container();
  bool isChekImage= true;

  void changeChicPoxImage() {
    isChekImage = !isChekImage;
    chekImage = isChekImage? Container() : Image.asset("assets/images/check.png");

    emit(AppRegisterChangeChicPoxImageState());
  }

  //موضوع الايقونة

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppChangePasswordVisibilityState());
  }
}
