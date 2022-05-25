import 'package:flutter/material.dart';
import 'package:asroo_shop/shared/styles/icon_broken.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background =const Color.fromARGB(255, 231, 0, 138),
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: (){
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: (){
        function();
        },
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  // Function? onSubmit,
  // Function? onChange,
  // Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String hintText,
  required Widget prefix, //الايقونة الي علشمال
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      cursorColor: Colors.black,//لون الموشر
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,// النص ظاهر ولا مختفي
      enabled: isClickable,
      // onFieldSubmitted: (s){
      //   onSubmit!(s);
      // },
      // onChanged: (s){
      //   onChange!(s);
      // },
      // onTap: (){
      //
      // },
      validator: (s){
        validate(s);
      },
      decoration: InputDecoration(
        filled: true,//هل اضلل الحقل من جوا
        prefixIcon: prefix,
      //  label:Text(hintText) , //هاي بتنحط بدل الهينت تيكست لمن اشغلها بتطلع ل فوق
        hintText: hintText,                //
        // hintStyle: TextStyle(
        //   color: Colors.white,
        // ),

        suffixIcon: suffix != null
            ? IconButton(
          onPressed: (){
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
      //  border: OutlineInputBorder(),//نوع الحقل
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
    );

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title??"",
  ),
  actions: actions,
);



Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);



void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );


// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

