import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shop_cubit/shop_cubit.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getFavorites(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =
              BlocProvider.of<ShopCubit>(context).favoritesModel?.data?.data;

          return state is! ShopLoadingGetFavoritesState
              ? cubit == null || cubit.isEmpty
                  ? const Center(
                      child: Text(
                        'No Favorites Found',
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildListProduct(
                        context: context,
                        model: cubit[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                        width: 90,
                        child: Divider(
                          color: Colors.grey[300],
                        ),
                      ),
                      itemCount: cubit.length,
                    )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
        },
      ),
    );
  }
}

Widget buildListProduct({
  required BuildContext context,
  required model,
}) {
  return model.product.id != 0
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            model.product.id != 0
                ? SizedBox(
                    height: 120,
                    width: 120,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image.network(
                          model.product.image,
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  )
                : Image.network(
                    "https://student.valuxapps.com/storage/uploads/products/1615440689wYMHV.item_XXL_36330138_142814934.jpeg",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        model.product.price.toString(),
                        style: const TextStyle(color: Colors.deepOrange),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (model.product.discount != 0)
                        Text(
                          model.product.oldPrice.round().toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          BlocProvider.of<ShopCubit>(context)
                              .changeFavorites(model.product.id);
                        },
                        icon: BlocProvider.of<ShopCubit>(context)
                                    .favorites[model.product.id] ==
                                true
                            ? const Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      : Container();
}
