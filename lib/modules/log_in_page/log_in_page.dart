import 'package:asroo_shop/asroo_layout.dart';
import 'package:asroo_shop/modules/log_in_page/cubit/cubit.dart';
import 'package:asroo_shop/modules/log_in_page/cubit/states.dart';
import 'package:asroo_shop/modules/register_screen/register_screen.dart';
import 'package:asroo_shop/shared/components/components.dart';
import 'package:asroo_shop/shared/network/local/cache_helper.dart';
import 'package:asroo_shop/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit,AppLoginStates>(
        listener: (context, state){

          if(state is AppLoginSuccessState)
          {
            CacheHelper.saveData(//تاع الشيرد ريفيرنسس هاد لكلاس عشان احفظ اليوزر الي دخل
              key: 'uId',
              value: state.uId,//استقبلنا اليوزر اي دي الي بعتناه
            ).then((value)
            {
              navigateAndFinish(context,Asroolayout());

            });
          }
        },
          builder: (context, state) {
            var cubit = AppLoginCubit.get(context);



            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.17,
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "LOG ",
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 35,
                                    ),
                                  ),
                                  Text(
                                    "IN ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),


                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: Colors.black,//لون الموشر
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,


                                validator: ( value) {
                                  if (value == null ||value.isEmpty) {
                                    return 'please enter your Email';
                                  }
                                },
                                decoration: InputDecoration(
                                  filled: true,//هل اضلل الحقل من جوا
                                  prefixIcon: Image.asset('assets/images/email.png'),
                                  //  label:Text(hintText) , //هاي بتنحط بدل الهينت تيكست لمن اشغلها بتطلع ل فوق
                                  hintText: "Email",                //

                                  enabledBorder: OutlineInputBorder(//نوع الحقل من غير مضغط عليه
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(//نوع الحقل لمن اضغط عليه
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                cursorColor: Colors.black,//لون الموشر
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: cubit.isPassword, //النص ظاهر ولا مختفي

                                validator: ( value) {
                                  if (value == null ||value.isEmpty) {
                                    return 'please enter your Password';
                                  }
                                },
                                decoration: InputDecoration(
                                  filled: true,//هل اضلل الحقل من جوا
                                  prefixIcon: Image.asset('assets/images/Password.png'),
                                  //  label:Text(hintText) , //هاي بتنحط بدل الهينت تيكست لمن اشغلها بتطلع ل فوق
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      cubit.changePasswordVisibility();
                                    },
                                    icon: Icon(
                                      cubit.suffix,
                                      color: Colors.grey,
                                    ),
                                  ),//

                                  enabledBorder: OutlineInputBorder(//نوع الحقل من غير مضغط عليه
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(//نوع الحقل لمن اضغط عليه
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: InkWell(
                                  onTap: (){

                                  },
                                  child: const Text("Forgot Password?",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      cubit.changeChicPoxImage();

                                    },
                                    child: Container(
                                      width: 34,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200,
                                      ),
                                    child: cubit.chekImage,
                                    ),
                                  ),
                                  const Text("   Remember me "),

                                ],
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              ConditionalBuilder(
                                condition: state is! AppLoginLoadingState,
                                builder: (context) =>   ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        emailController.text,
                                        passwordController.text,
                                        context,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff00be84),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.height * .1,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text(
                                    'LOG IN',
                                    style: TextStyle(
                                        fontFamily: 'Circe',
                                        fontSize: 20,
                                        color: Color(0xffffffff)),
                                  ),
                                ),

                                fallback: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              const Text("OR"),
                              const SizedBox(
                                height: 35,
                              ),
                              Center(
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset("assets/images/facebook.png"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset("assets/images/google.png"),
                                  ],),
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 95,
                        decoration: const BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.only(
                            topLeft:Radius.circular(25),
                            topRight:Radius.circular(25),
                          ),

                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Don't have an Account?",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,

                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateAndFinish(context,RegisterScreen());
                                },
                                child: const Text(
                                  " Sign up",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),



                    ],
                  ),
                ),
              ),
            );
        },

      ),
    );
  }
}
