import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/images_helpers.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/routing/app_routes.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/app_text_form.dart';
import 'package:academe_mobile_new/features/attendance/model/student_model.dart';
import 'package:academe_mobile_new/features/attendance/widgets/item_loading.dart';
import 'package:academe_mobile_new/features/home/data/model/subject_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon_broken/icon_broken.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.model});
  final SubjectCardModel model;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFrom(
                      withhint: false,
                      hintText: 'Search by ID',
                      controller: searchController,
                      prefixText: 'C',
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AppCubit>().search(
                                  searchController.text,
                                  widget.model.level,
                                  '123');
                            }
                          },
                          icon: const Icon(IconBroken.Search)),
                      validator: (value) {
                        if (value!.isEmpty || value.length != 7) {
                          return 'Please enter valid id';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  verticalSpace(20),
                  state is SearchLoadingState
                      ? const Expanded(child: ItemLoading())
                      : context.read<AppCubit>().searchModel.name != null &&
                              state is SearchSuccessState
                          ? item(context, context.read<AppCubit>().searchModel)
                          : state is SearchErrorState
                              ? Text(
                                  state.error,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                              : const SizedBox()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget item(BuildContext context, StudentModel model) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutes.studentInfo, arguments: model);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow,
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ]),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Image(
                image: AssetImage(ImagesHelpers.genderImage(model.gender)),
                height: 40.h,
              ),
              title: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  model.name!,
                  style: theme.textTheme.headlineMedium),
              subtitle: Text(model.id.toString(),
                  style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.grey[500])),
              trailing: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Text(model.attendance.toString(),
                      style: theme.textTheme.headlineSmall!
                          .copyWith(color: Colors.white))),
            )),
      ),
    );
  }
}
