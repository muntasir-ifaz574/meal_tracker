import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../business_logics/providers/auth_provider.dart';
import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';
import '../../widgets/custom_warning_message_widget.dart';
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
                Platform.isAndroid
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(onPressed: (){
                        Navigator.pop(context);
                      },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: kBlackColor,
                        ),
                      ),
                    ),
                  )
                : SizedBox(height: 10.h),

                Container(
                  width: 45.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEAF4F2),
                  ),
                  child: Image.asset("assets/images/auth_screen_image.png"),
                ),
                SizedBox(height: 5.h),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(30)),
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
                          controller: newUserNameController,
                          textInputAction: TextInputAction.next,
                          context: context,
                          label: "Name",
                          hint: "Enter Your Name",
                          focusNode: newUserNameFocusNode,
                        ),
                      ),
                      //Email
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: WidgetFactory.buildTextField(
                          controller: newUserEmailController,
                          textInputType: TextInputType.emailAddress,
                          context: context,
                          label: "Email",
                          hint: "email@example.com",
                          focusNode: newUserEmailFocusNode,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      //Password
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: WidgetFactory.buildTextField(
                          controller: newUserPasswordController,
                          textInputType: TextInputType.text,
                          context: context,
                          label: "Password",
                          hint: "12*****8",
                          focusNode: newUserPasswordFocusNode,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      //Already have account Sing Up
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
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return authProvider.inProgress
                              ? const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Center(
                                    child: CircularProgressIndicator(
                                      color: kThemeColor,
                                    ),
                                  ),
                              )
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: double.infinity,
                                  height: 8.h,
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: WidgetFactory.buildButton(
                                    context: context,
                                    onPressed: () async {
                                      String name = newUserNameController.text.toString();
                                      String email = newUserEmailController.text.toString();
                                      String password = newUserPasswordController.text.toString();

                                      if(newUserNameController.text.isNotEmpty && newUserEmailController.text.isNotEmpty && newUserPasswordController.text.isNotEmpty){
                                        AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                                        bool response = await authProvider.signUpProvider(
                                            username: name,
                                            email: email,
                                            password: password
                                        );
                                        if (response) {
                                          if (!mounted) return;
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const SignInScreen()),
                                                  (Route<dynamic> route) => false);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Your account has been created successfully! Please SignIn to continue"),
                                            ),
                                          );
                                        } else {
                                          if (!mounted) return;
                                          customWidget.showCustomSnackbar(
                                              context,
                                              authProvider
                                                  .errorResponse?.message);
                                        }
                                      }else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Please fill all field."),
                                          ),
                                        );
                                      }


                                    },
                                    text: "SIGN UP",
                                    backgroundColor: kThemeColor,
                                    borderColor: Colors.transparent,
                                  ),
                                );
                        },
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
