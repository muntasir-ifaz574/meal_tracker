import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mealtracker/src/business_logics/providers/common_provider.dart';
import 'package:mealtracker/src/views/ui/edit_meal_screen.dart';
import 'package:mealtracker/src/views/utils/colors.dart';
import 'package:mealtracker/src/views/utils/custom_text_style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/custom_warning_message_widget.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({Key? key}) : super(key: key);

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CommonProvider commonProvider =
      Provider.of<CommonProvider>(context, listen: false);
      _mealLIst(commonProvider);
    });
  }

  _mealLIst(CommonProvider commonProvider) {
    commonProvider.mealListProvider();
  }



  String formatDateString(String dateString) {
    final dateTime = DateTime.parse(dateString);
    final formatter = DateFormat('h:mm a EEE d MMM y');
    return formatter.format(dateTime);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        const Text(
                          "Your Meal List",
                          style: kHLargeTitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                    child: Lottie.asset(
                        'assets/lotties/meal_list_lottie.json'),
                  ),
                  SizedBox(height: 5.h),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Meal List",
                        style: kHSubTitleTextStyle,
                      ),
                    ),
                  ),
                  const Divider(
                    color: kThemeColor,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Consumer<CommonProvider>(
                    builder: (context, commonProvider, child) {
                      if (commonProvider.inProgress) {
                        return Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: const CircularProgressIndicator(
                            color: kThemeColor,
                          ),
                        );
                      } else {
                        if (commonProvider.mealListResponseModel?.data?.isNotEmpty == true) {
                          return Column(
                            children: [
                              ...commonProvider.mealListResponseModel!.data!.map((meal) {
                                final index = commonProvider.mealListResponseModel!.data!.indexOf(meal);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: kWhiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              color: int.parse(commonProvider.mealListResponseModel?.data?[index].calories as String) >= 1500
                                                  ? Colors.red.withOpacity(0.25)
                                                  : Colors.grey.withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15, bottom: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    width: 60,
                                                    child: Lottie.asset(
                                                      commonProvider.mealListResponseModel?.data?[index].type == "Dinner"
                                                          ? "assets/lotties/dinner_lottie.json"
                                                          : commonProvider.mealListResponseModel?.data?[index].type == "Lunch"
                                                          ? "assets/lotties/lunch_lottie.json"
                                                          : "assets/lotties/breackfast_lottie.json",
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => EditMealScreen(
                                                                    mealId: commonProvider.mealListResponseModel?.data?[index].id as int,
                                                                    mealType:  commonProvider.mealListResponseModel?.data?[index].type as String,
                                                                    whatYouEat:  commonProvider.mealListResponseModel?.data?[index].name as String,
                                                                    totalCalorie:  commonProvider.mealListResponseModel?.data?[index].calories as String,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.edit,
                                                              color: kThemeColor,
                                                            ),
                                                          ),
                                                          commonProvider.isDelete
                                                          ? SizedBox(
                                                            height: 3.h,
                                                            width: 6.w,
                                                            child: const CircularProgressIndicator(
                                                              color: Colors.red,
                                                            ),
                                                          )
                                                          : IconButton(
                                                            onPressed: () async {
                                                              CommonProvider commonProvider = Provider.of<CommonProvider>(context, listen: false);
                                                              bool response = await commonProvider.deleteMealProvider(id: commonProvider.mealListResponseModel?.data?[index].id as int);
                                                              if (response) {
                                                                if (!mounted) return;
                                                                setState(() {
                                                                  commonProvider.mealListResponseModel!.data!.removeAt(index);
                                                                });
                                                              } else {
                                                                if (!mounted) return;
                                                                customWidget.showCustomSnackbar(context, commonProvider.errorResponse?.message);
                                                              }
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .delete_outline_rounded,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "Calories: ${commonProvider.mealListResponseModel?.data?[index].calories ?? "N/A"}",
                                                        style: TextStyle(
                                                          fontFamily: "Nunito",
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 16.sp,
                                                          color: int.parse(commonProvider.mealListResponseModel?.data?[index].calories as String) >= 1500
                                                              ? Colors.red
                                                              : kBlackColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  commonProvider.mealListResponseModel?.data?[index].type ?? "N/A",
                                                  style: kHSmallTitleTextStyle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 90.w,
                                                child: Text(
                                                  commonProvider.mealListResponseModel?.data?[index].name ?? "N/A",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                    color: kBlackColor,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  formatDateString(commonProvider.mealListResponseModel?.data?[index].time ?? "N/A") ,
                                                  style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    color: kBlackColor,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      int.parse(commonProvider.mealListResponseModel?.data?[index].calories as String) >= 1500
                                          ? Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          height: 2.h,
                                          width: 20.w,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(10),
                                              )
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Heavy Meal",
                                              style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 13.5.sp,
                                                color: kWhiteColor,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Container(
                              child: Lottie.asset("assets/lotties/no_data_lottie.json"),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
