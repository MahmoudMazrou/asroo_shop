
import 'package:asroo_shop/shared/cubit/cubit.dart';
import 'package:asroo_shop/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return ConditionalBuilder(
          condition: state is! AppLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => Container(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width:100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child :  Image(
                        height: 100,
                      image: NetworkImage(
                          cubit.prodect?[cubit.idFavourite[index]-1]["image"]??
                              "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=620&quality=45&auto=format&fit=max&dpr=2&s=6fe0ebd22151102996062fa1287f824c"),

                    ),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cubit.prodect?[cubit.idFavourite[index]-1]["title"],
                            maxLines: 1,
                          //  overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Circe',
                              fontSize: 18,
                              color: const Color(0xff000000),
                          //    letterSpacing: 0.36,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(" "+
                            cubit.prodect?[cubit.idFavourite[index]-1]["category"],
                            style: TextStyle(
                              fontFamily: 'Circe',
                              fontSize: 13,
                              color: const Color(0xab000000),
                              letterSpacing: 0.26,
                            ),
                            softWrap: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon:  Icon(Icons.favorite,color: Colors.red,),
                    onPressed: () {
                      cubit.addOrRemoveFavourite(cubit.prodect?[cubit.idFavourite[index]-1]["id"]);
                    },
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) =>
                Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: cubit.idFavourite.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}