import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_application/shop_cubit/shop_cubit.dart';
import 'package:shop_application/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccessFavoritesState) {
          if (state.model.status == false) {
            Fluttertoast.showToast(
              msg: state.model.message.toString(),
              backgroundColor: Colors.red,
              gravity: ToastGravity.BOTTOM,
              fontSize: 20,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<ShopCubit>(context);
        return Scaffold(
          body: cubit.isSuccessOne == "Error" && cubit.isSuccessTwo == "Error"
              ? const Center(
                  child: Text(
                    "error",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : cubit.isSuccessOne == "Done" && cubit.isSuccessTwo == "Done"
                  ? productsBuilder(
                      context: context,
                      model: cubit.homeModel!,
                      categoriesModel: cubit.categories!,
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
        );
      },
    );
  }
}
