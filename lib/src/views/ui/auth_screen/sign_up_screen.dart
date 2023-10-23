import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';
import '../../widgets/widget_factory.dart';
import 'controller.dart';
import 'sign_in_screen.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: const Color(0xFFEAF4F2),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    child: const Icon(
                      Icons.arrow_back,
                      color: kBlackColor,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ),
                Container(
                  // height: 15.h,
                  width: 45.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEAF4F2),
                  ),
                  child: Image.asset("assets/images/auth_screen_image.png"),
                ),
                SizedBox(height: 5.h),
                Container(
                  // height: 90.h,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Text(
                          "SIGN UP",
                          style: kLargeTitleTextStyle,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Sign Up now to begin an amazing journey",
                          style: ksTitelTextStyle,
                        ),
                      ),
                      //Name
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: WidgetFactory.buildTextField(
                          textInputAction: TextInputAction.next,
                          context: context,
                          label: "Name",
                          hint: "Enter Your Name",
                          focusNode: namesETFocusNode,
                        ),
                      ),
                      //Email
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: WidgetFactory.buildTextField(
                          textInputType: TextInputType.emailAddress,
                          context: context,
                          label: "Email",
                          hint: "email@example.com",
                          focusNode: emailETFocusNode,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      //Gender
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SizedBox(
                          height: 6.h,
                          width: double.infinity,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            hint: const Text(
                              "Select Gender",
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
                                "Gender",
                                style: TextStyle(
                                  fontFamily: 'latoRagular',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF102048),
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
                                borderSide: const BorderSide(
                                    color: Color(0xFF808080)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              // setState(() {
                              //   dropdownValue = newValue!;
                              // });
                            },
                            items: <String>[
                              "Male",
                              "Female",
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontFamily: 'latoRagular',
                                    color: kThemeColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      //Already have accout Sing Up
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Already have account? ",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: kBlackColor,
                                fontFamily: 'latoRagular',
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign in",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kThemeColor,
                                    fontFamily: 'latoRagular',
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Sing Up Button
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 8.h,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: WidgetFactory.buildButton(
                          context: context,
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const SignupOTPScreen(),
                            //   ),
                            // );
                          },
                          text: "SIGN UP",
                          backgroundColor: kThemeColor,
                          borderColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
