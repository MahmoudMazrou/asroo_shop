import 'package:asroo_shop/asroo_layout.dart';
import 'package:asroo_shop/modules/log_in_page/log_in_page.dart';
import 'package:asroo_shop/modules/register_screen/cubit/cubit.dart';
import 'package:asroo_shop/modules/register_screen/cubit/states.dart';
import 'package:asroo_shop/shared/applocal.dart';
import 'package:asroo_shop/shared/components/components.dart';
import 'package:asroo_shop/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
        listener: (context, state) {
          if (state is AppCreateUserSuccessState) {
            //بقلك اذ تسجيل الخول تم وصحيح نفذ
            CacheHelper.saveData(
              //تاع الشيرد ريفيرنسس هاد لكلاس عشان احفظ اليوزر الي دخل
              key: 'uId',
              value: state.uId, //استقبلنا اليوزر اي دي الي بعتناه
            ).then((value) {
              navigateAndFinish(context,Asroolayout());

            });
          }
        },
        builder: (context, state) {
          var cubit = AppRegisterCubit.get(context);

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
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                            ),
                            Row(
                              children: const [
                                Text(
                                  "SIGN ",
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 35,
                                  ),
                                ),
                                Text(
                                  "UP ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.12,
                            ),
                            TextFormField(
                              cursorColor: Colors.black,//لون الموشر
                              controller: nameController,
                              keyboardType: TextInputType.name,


                              validator: ( value) {
                                if (value == null ||value.isEmpty) {
                                  return 'please enter your name';
                                }
                              },
                              decoration: InputDecoration(
                                filled: true,//هل اضلل الحقل من جوا
                                prefixIcon: Image.asset('assets/images/person.png'),
                                //  label:Text(hintText) , //هاي بتنحط بدل الهينت تيكست لمن اشغلها بتطلع ل فوق
                                hintText: "${getLang(context, "regester_hint_name_String")}",                //

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
                                hintText: "Password", //
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    cubit.suffix,
                                    color: Colors.grey,
                                  ),
                                ),

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
                                const Text("   I accept "),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "terms & conditions",
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),

                            ConditionalBuilder(
                              condition: state is! AppRegisterLoadingState,
                              builder: (context) => ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context,
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
                                  'SIGN UP',
                                  style: TextStyle(
                                      fontFamily: 'Circe',
                                      fontSize: 20,
                                      color: Color(0xffffffff)),
                                ),
                              ),


                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
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
                            const Text("Already have an Account?",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,

                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateAndFinish(context,LogInPage());
                              },
                              child: const Text(
                                "Log in",
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
