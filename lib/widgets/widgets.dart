import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shop_application/models/categories_model.dart';
import 'package:shop_application/models/home_model.dart';
import 'package:shop_application/network/end_points.dart';
import 'package:shop_application/shop_cubit/shop_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

BuildContext? context;
Widget subTitleText(
  context,
  String onBoardingItems,
) =>
    Text(
      onBoardingItems,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    );
Widget changeTo(context, void Function()? onPressed, IconData? iconData) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      iconData,
      color: Colors.black,
    ),
  );
}

Widget indicatorWidget(PageController pageController, int count) {
  return SmoothPageIndicator(
    controller: pageController,
    count: count,
    effect: const WormEffect(
      dotColor: Colors.grey,
      activeDotColor: Colors.black,
    ),
  );
}

navigationAndRemove(context, String routeName) {
  return Navigator.pushNamedAndRemoveUntil(
      context, routeName, (route) => false);
}

customElevatedButton(void Function()? onPressed, String hintText) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      minimumSize: const Size(230, 55),
      shape: const StadiumBorder(),
    ),
    child: Text(
      hintText,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

navigationNameToPage(context, String routeName) {
  return Navigator.pushNamed(context, routeName);
}

productsBuilder({
  required HomeModel model,
  required CategoriesModel categoriesModel,
  required BuildContext context,
}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners!
              .map((e) =>
                  Image.network(
                    width: double.infinity,
                    e.image ?? EndPoints.errorImage,
                  ) ??
                  Image.asset(
                    "assets/3d-casual-life-mirror-selfie-with-shopping-bags-and-new-jacket.png",
                    width: double.infinity,
                  ))
              .toList(),
          options: CarouselOptions(
            height: 200,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Electronics",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  itemCount: categoriesModel.data.data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      buildCategoryItem(categoriesModel, index),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 7,
                  ),
                  physics: const BouncingScrollPhysics(),
                ),
              ),
              Text(
                "New Products",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1 / 1.55,
            children: List.generate(
                model.data!.products!.length,
                (index) =>
                    buildGridProduct(model.data!.products![index], context)),
          ),
        ),
      ],
    ),
  );
}

Widget buildCategoryItem(CategoriesModel model, int index) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image.network(
        model.data.data[index].image,
        height: 100,
        width: 100,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        // height: 100,
        child: Text(
          model.data.data[index].name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget buildGridProduct(model, BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        model.discount != 0
            ? Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image.network(
                    "${model.image ?? EndPoints.errorImage}",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: const Text(
                      "DISCOUNT",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            : Image.network(
                "${model.image ?? EndPoints.errorImage}",
                width: double.infinity,
                height: 200,
                fit: BoxFit.contain,
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 37,
                child: Text(
                  "${model.name ?? ""}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "${model.price.round()}",
                    style: const TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0)
                    Text(
                      "${model.oldPrice.round()}",
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
                          .changeFavorites(model.id);
                      if (kDebugMode) {
                        print(model.id);
                      }
                    },
                    icon: BlocProvider.of<ShopCubit>(context)
                                .favorites[model.id] ==
                            true
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            color: Colors.black,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// IconButton(
// onPressed: () async {
// dynamic data =
// await CacheHelper.clearData(key: EndPoints.token) ??
// false;
// if (data == false) {
// navigationAndRemove(context, ShopLoginScreen.routeName);
// }
// },
// icon: const Icon(
// Icons.exit_to_app,
// ),
// ),
