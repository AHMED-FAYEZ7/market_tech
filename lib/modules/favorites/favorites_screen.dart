import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_tech/shared/componants/componants.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! AppLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListItems(
              AppCubit.get(context).favoritesModel!.data!.fave[index].product!,
              context,
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                height: 1,
                color: Colors.grey,
                width: double.infinity,
              ),
            ),
            itemCount: AppCubit.get(context).favoritesModel!.data!.fave.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
