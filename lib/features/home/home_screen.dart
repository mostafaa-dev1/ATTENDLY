import 'package:academe_mobile_new/core/Constants/constants.dart';
import 'package:academe_mobile_new/core/helpers/extentions.dart';
import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:academe_mobile_new/core/logic/app_cubit.dart';
import 'package:academe_mobile_new/core/themes/colors.dart';
import 'package:academe_mobile_new/core/widgets/alert.dart';
import 'package:academe_mobile_new/core/widgets/sacffold_messinger.dart';
import 'package:academe_mobile_new/features/home/widgets/banner.dart';
import 'package:academe_mobile_new/features/home/widgets/qr_button.dart';
import 'package:academe_mobile_new/features/home/widgets/subject_cards.dart';
import 'package:academe_mobile_new/features/home/widgets/top_name_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _AppState();
}

class _AppState extends State<Home> {
  late bool isAvailable;

  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().init();
    context.read<AppCubit>().getHomeData(false);
    // endDate = getNextFriday();
    // isAvailable = DateTime.friday != DateTime.now().weekday;
  }

  DateTime getNextFriday() {
    DateTime now = DateTime.now();
    int daysToAdd = (DateTime.friday - now.weekday + 7) % 7;
    if (daysToAdd == 0) {
      daysToAdd = 7;
    }
    DateTime nextFriday = now.add(Duration(days: daysToAdd));
    return DateTime(nextFriday.year, nextFriday.month, nextFriday.day, 0, 0, 0);
  }

  bool isDate = DateTime.now().isAfter(DateTime(2025, 3, 30));
  String version = Constants.version;

  @override
  Widget build(BuildContext context) {
    print(version);
    var cubit = context.read<AppCubit>();
    print(cubit.version);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetDataErrorState) {
          scaffoldMessinger(
              context: context,
              message: state.error,
              icon: IconBroken.Info_Circle,
              isError: true);
        } else if (state is GetVersionSuccessState) {
          if (state.version != version) {
            showAlert(context, 'Update Available',
                'A new version of Academe is available. \nPlease update to continue using the app.',
                () {
              context.pop();
            }, () {
              context.pop();
            }, 'OK', 'Cancel', IconBroken.Info_Circle, false, '');
          }
        }
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: RefreshIndicator(
              color: AppColors.mainColor,
              backgroundColor: Theme.of(context).colorScheme.primary,
              onRefresh: () => cubit.getHomeData(true),
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 400,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
                      child: Text(
                        'Subjects',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        TopNameBar(),
                        verticalSpace(20),
                        HomeBanner(
                          version: version,
                        ),
                        verticalSpace(20),
                        QrButton(
                          version: version,
                        ),
                        verticalSpace(20),
                      ],
                    ),
                  )),
                ),
                SliverToBoxAdapter(
                  child: SubjectCards(),
                )
              ]),
            ),
          )),
    );
  }
}
