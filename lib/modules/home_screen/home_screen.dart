import 'package:asroo_shop/models/prodect_model.dart';
import 'package:asroo_shop/shared/cubit/cubit.dart';
import 'package:asroo_shop/shared/cubit/states.dart';
import 'package:asroo_shop/shared/styles/colors.dart';
import 'package:asroo_shop/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 240,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30, left: 23),
                      child: Text("Find Your \nInspiration",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),

                      ),
                    ),
                    const SizedBox(height: 35),
                    Row(children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          cursorColor: Colors.black, //لون الموشر
                          decoration: InputDecoration(
                            filled: true,
                            //هل اضلل الحقل من جوا
                            prefixIcon: Image.asset('assets/images/Search.png'),
                            //  label:Text(hintText) , //هاي بتنحط بدل الهينت تيكست لمن اشغلها بتطلع ل فوق
                            hintText: "   Search you're looking for",
                            fillColor: Colors.white,

                            enabledBorder: OutlineInputBorder( //نوع الحقل من غير مضغط عليه
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder( //نوع الحقل لمن اضغط عليه
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Image.asset(
                          "assets/images/Icon material-filter-list.png"),
                      const SizedBox(width: 8),


                    ],)

                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontFamily: 'Circe',
                    fontSize: 20,
                    color: Color(0xff000000),
                    letterSpacing: 0.52,
                    height: 1.25,
                  ),
                  textHeightBehavior: TextHeightBehavior(
                      applyHeightToFirstAscent: false),
                  softWrap: false,
                ),
              ),
              ConditionalBuilder(
                condition: state is! AppLoadingGetProductsState,
                builder: (context) =>
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      //وقفنا السكرول فيها عشان في سكرول خارجي
                      crossAxisCount: 2,
                      //تنين جمب بعض
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: 1 / 1.5,
                      children: List.generate(
                        10,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                    //
                                      children: [
                                        IconButton(
                                          icon:cubit.isFavourite(cubit.prodect?[index]["id"]) ? Icon(Icons.favorite_border): Icon(Icons.favorite,color: Colors.red,),
                                          onPressed: () {
                                          cubit.addOrRemoveFavourite(cubit.prodect?[index]["id"]);
                                        },
                                            ),
                                        Spacer(),
                                        Icon(
                                            Icons.shopping_cart_sharp),

                                      ],),
                                    Image(
                                      height: 180,
                                      width: double.infinity,
                                      image: NetworkImage(
                                          cubit.prodect?[index]["image"] ??
                                              "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=620&quality=45&auto=format&fit=max&dpr=2&s=6fe0ebd22151102996062fa1287f824c"),
                                      fit: BoxFit.fill,

                                    ),
                                    Row(

                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2, left: 15),
                                          child: Text("\$ ${cubit
                                              .prodect?[index]["price"] ?? ""}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),

                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2, right: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius
                                                  .circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  6.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${cubit
                                                        .prodect?[index]["rating"]["rate"] ??
                                                        " "} ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Icon(Icons.star,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],),

                                  ],
                                ),
                              ),
                            );
                          }

                      ),
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),

            ],
          ),
        );
      },
    );
  }
}

// Widget buildGridProduct(ProductModel model, context) => Container(
//   color: Colors.white,
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       InkWell(
//         onTap: () {
//        //   navigateTo(context, ProductsDetails(model),); //ارسلناه الى صفحة التفاصيل
//
//         },
//         child: Stack(
//           alignment: AlignmentDirectional.bottomStart,
//           children: [
//             Image(
//               image: NetworkImage(model.image),
//               width: double.infinity,
//               height: 200.0,
//             ),
//             if (model.discount != 0) //لمن يكون في خصم
//               Container(
//                 color: Colors.red,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 5.0,
//                 ),
//                 child: Text(
//                   'DISCOUNT',
//                   style: TextStyle(
//                     fontSize: 8.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               model.name,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 14.0,
//                 height: 1.3, //بقرب النص من بعض لسطور يعني
//               ),
//             ),
//             Row(
//               children: [
//                 Text(
//                   '${model.price.round()}',//round عشان اذ اجا دبل يحولو ل عدد صحيح
//                   style: TextStyle(
//                     fontSize: 12.0,
//                     color: defaultColor,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 5.0,
//                 ),
//                 if (model.discount != 0)//لمن يكون في خصم
//                   Text(
//                     '${model.oldPrice.round()}',
//                     style: TextStyle(
//                       fontSize: 10.0,
//                       color: Colors.grey,
//                       decoration: TextDecoration.lineThrough, //حط خط فوق النص
//                     ),
//                   ),
//                 Spacer(),
//                 IconButton(
//                   onPressed: () {
//                     ShopCubit.get(context).changeFavorites(model.id);//بستدعيهاوبعطيها الاي دي تاع لبرودكت الي بضغط عليه فهو تلقئي بغير
//                     print(model.id);
//                   },
//                   icon: CircleAvatar(
//                     radius: 15.0,
//                     backgroundColor:
//                     ShopCubit.get(context).favorites[model.id]//بعمل ليسن  ع الفيفرت وبجيب منها خد بالك انها ماب
//                         ? defaultColor
//                         : Colors.grey,
//                     child: Icon(
//                       Icons.favorite_border,
//                       size: 14.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// );
