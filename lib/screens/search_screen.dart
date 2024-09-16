import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/search_cubit/search_cubit.dart';
import 'package:shop_application/widgets/settings_text_form_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const String routeName = '/search_screen';

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var cubit = BlocProvider.of<SearchCubit>(context);

    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit2 = cubit.searchModel?.data.data;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SettingsTextFormField(
                    onChanged: (String text) {
                      cubit.search(text);
                    },
                    controller: searchController,
                    hintText: "Search",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(color: Colors.black,),
                  if (state is SearchSuccessState &&
                      (cubit2 == null || cubit2.isEmpty))
                    const Center(
                      child: Text(
                        "No results found.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  // إذا كانت البيانات موجودة
                  if (state is SearchSuccessState &&
                      cubit2 != null &&
                      cubit2.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemCount: cubit2.length,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                          width: 90,
                          child: Divider(
                            color: Colors.grey[300],
                          ),
                        ),
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cubit2[index].id != 0
                                ? SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        Image.network(
                                          cubit2[index].image,
                                          width: double.infinity,
                                          height: 120,
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
                                    cubit2[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14, height: 1.3),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        cubit2[index].price.toString(),
                                        style: TextStyle(
                                            color: Colors.blueAccent.shade700),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ],
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
    );
  }
}
