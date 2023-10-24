import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mealtracker/src/business_logics/providers/common_provider.dart';
import 'package:mealtracker/src/views/ui/home_screen.dart';
import 'package:mealtracker/src/views/utils/colors.dart';
import 'package:mealtracker/src/views/utils/custom_text_style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/custom_warning_message_widget.dart';
import '../widgets/widget_factory.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  String? mealTypes;

  FocusNode whatYouEatFocusNode = FocusNode();
  FocusNode totalCalorieFocusNode = FocusNode();

  var whatYouEatController = TextEditingController();
  var totalCalorieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      "Add Your Meal",
                      style: kHLargeTitleTextStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
                child: Lottie.asset('assets/lotties/add_meal_lottie.json'),
              ),

              ///-----------------Select Meal Type----------------------///
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 6.h,
                width: double.infinity,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  hint: const Text(
                    "Breakfast",
                    style: TextStyle(
                      fontFamily: 'latoRagular',
                      fontSize: 13,
                      color: Color(0xFFC4C4C4),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  // value: dropdownValue,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(10.0),
                    label: const Text(
                      "Meal Type",
                      style: TextStyle(
                        fontFamily: 'latoRagular',
                        fontWeight: FontWeight.w600,
                        color: kThemeColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF808080),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF808080)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      mealTypes = newValue!;
                    });
                  },
                  items: <String>[
                    "Breakfast",
                    "Lunch",
                    "Dinner",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          color: kBlackColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              ///-----------------What you eat--------------------------///
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                height: 17.5.h,
                child: WidgetFactory.buildTextField(
                  maxline: 5,
                  controller: whatYouEatController,
                  textInputAction: TextInputAction.next,
                  context: context,
                  label: "What you eat?",
                  hint: "Rice with beef and salad",
                  focusNode: whatYouEatFocusNode,
                ),
              ),

              ///-----------------Total Calories--------------------------///
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 20),
                child: WidgetFactory.buildTextField(
                  controller: totalCalorieController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  context: context,
                  label: "Total Calorie",
                  hint: "Enter total calorie",
                  focusNode: totalCalorieFocusNode,
                ),
              ),

              ///-----------------Submit Button---------------------------///
              Consumer<CommonProvider>(
                builder: (context, authProvider, child) {
                  return authProvider.inProgress
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: kThemeColor,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          height: 6.h,
                          child: WidgetFactory.buildButton(
                            context: context,
                            onPressed: () async {
                              String mealType = mealTypes.toString();
                              String whatYouEat = whatYouEatController.text.toString();
                              String totalCalorie = totalCalorieController.text.toString();
                              CommonProvider commonProvider = Provider.of<CommonProvider>(context, listen: false);
                              bool response = await commonProvider.addMealProvider(
                                mealType: mealType,
                                whatYouEat: whatYouEat,
                                totalCalorie: totalCalorie,
                              );
                              if (response) {
                                if (!mounted) return;
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                    (Route<dynamic> route) => false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Your meal has been added successfully!"),
                                  ),
                                );
                              } else {
                                if (!mounted) return;
                                customWidget.showCustomSnackbar(context,
                                    commonProvider.errorResponse?.message);
                              }
                            },
                            text: "Submit",
                            backgroundColor: kThemeColor,
                            borderColor: Colors.transparent,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
