import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mealtracker/src/business_logics/providers/common_provider.dart';
import 'package:mealtracker/src/views/utils/colors.dart';
import 'package:mealtracker/src/views/utils/custom_text_style.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/custom_warning_message_widget.dart';
import '../widgets/widget_factory.dart';

class EditMealScreen extends StatefulWidget {
  final String mealType;
  final String whatYouEat;
  final String totalCalorie;
  final int mealId;

  const EditMealScreen({
    Key? key,
    required this.mealType,
    required this.whatYouEat,
    required this.totalCalorie,
    required this.mealId,
  }) : super(key: key);

  @override
  State<EditMealScreen> createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController whatYouEatController = TextEditingController();
  final TextEditingController totalCalorieController = TextEditingController();
  String? mealTypes;

  FocusNode whatYouEatFocusNode = FocusNode();
  FocusNode totalCalorieFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    whatYouEatController.text = widget.whatYouEat;
    totalCalorieController.text = widget.totalCalorie;
    mealTypes = widget.mealType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        "Edit Your Meal",
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
                        fontFamily: 'latoRegular',
                        fontSize: 13,
                        color: Color(0xFFC4C4C4),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                          borderSide: const BorderSide(
                            color: kGreyColor,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: kGreyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kThemeColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: mealTypes, // Make sure this matches one of the items
                    onChanged: (String? newValue) {
                      setState(() {
                        mealTypes = newValue;
                      });
                      _formKey.currentState!.save(); // Save the form data
                    },
                    items: <String>[
                      "Breakfast",
                      "Lunch",
                      "Dinner", // Fixed the typo here
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
                      left: 15, right: 15, top: 20, bottom: 10),
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

                ///-----------------Total Calories------------------------///
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 20),
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

                ///-----------------Submit Button-------------------------///
                Consumer<CommonProvider>(
                  builder: (context, authProvider, child) {
                    return authProvider.inProgress
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: kThemeColor,
                      ),
                    )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            width: double.infinity,
                            height: 6.h,
                            child: WidgetFactory.buildButton(
                                context: context,
                                onPressed: () async {
                                  int id = widget.mealId;
                                  String mealType = mealTypes!;
                                  String whatYouEat = whatYouEatController.text;
                                  String totalCalorie = totalCalorieController.text;
                                    CommonProvider commonProvider = Provider.of<CommonProvider>(context, listen: false);
                                    bool response = await commonProvider.editMealProvider(
                                      id: id,
                                      mealType: mealType,
                                      whatYouEat: whatYouEat,
                                      totalCalorie: totalCalorie,
                                    );
                                    if (response) {
                                      if (!mounted) return;
                                      Navigator.pop(context,true);
                                      customWidget.showCustomSnackBar(context, "Your meal has been edited successfully!");
                                    } else {
                                      if (!mounted) return;
                                      customWidget.showCustomWarningSnackBar(context, commonProvider.errorResponse?.message);
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
      ),
    );
  }
}
