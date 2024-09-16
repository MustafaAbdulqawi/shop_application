import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/categories_model.dart';
import 'package:shop_application/shop_cubit/shop_cubit.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getCategories(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<ShopCubit>(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: cubit.categories != null
                ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildCatItem(model: cubit.categories!, index: index),
              separatorBuilder: (context, index) =>
                  SizedBox(
                    height: 10,
                    width: double.infinity,
                    child: Divider(
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: cubit.categories!.data.data.length,
            )
                : const Center(
                child: CircularProgressIndicator(color: Colors.black,)),
          );
        },
      ),
    );
  }

  Widget buildCatItem({required CategoriesModel model, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image.network(
            model.data.data[index].image,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            model.data.data[index].name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
