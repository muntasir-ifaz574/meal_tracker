import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../business_logics/providers/auth_provider.dart';
import '../../../routes.dart';
import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';
import '../../widgets/custom_warning_message_widget.dart';
import '../../widgets/widget_factory.dart';
import 'controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: const Color(0xFFEAF4F2),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: mHeight / 2.1,
                width: 70.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF4F2),
                ),
                child: Image.asset("assets/images/auth_screen_image.png"),
              ),
              Container(
                width: 100.w,
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Text(
                        "SIGN IN",
                        style: kLargeTitleTextStyle,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Sign In now to begin an amazing journey",
                        style: ksTitelTextStyle,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 10),
                      child: WidgetFactory.buildTextField(
                          controller: userEmailController,
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          context: context,
                          label: "Email",
                          hint: "user@example.com",
                          focusNode: userEmailFocusNode),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: WidgetFactory.buildTextField(
                        controller: userPasswordController,
                        context: context,
                        obscureText: isSecurePassword,
                        suffixIcon: togglePassword(),
                        label: "Password",
                        hint: "Password",
                        focusNode: userPasswordFocusNode,
                        maxline: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don’t have account? ",
                          style: TextStyle(
                            fontSize: 16.5.sp,
                            fontWeight: FontWeight.w400,
                            color: kBlackColor,
                            fontFamily: 'latoRagular',
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: kThemeColor,
                                fontFamily: 'latoRagular',
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                    context,
                                      Routes.signUpScreen,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                      return authProvider.inProgress
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kThemeColor,
                              ),
                            )
                          : SizedBox(
                              height: 6.h,
                              width: 90.w,
                              child: WidgetFactory.buildButton(
                                context: context,
                                onPressed: () async {
                                  String email = userEmailController.text.toString();
                                  String password = userPasswordController.text.toString();
                                  if(userEmailController.text.isNotEmpty && userPasswordController.text.isNotEmpty){
                                    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                                    bool response = await authProvider.signInProvider(email: email, password: password);
                                    if (response) {
                                      userEmailController.clear();
                                      userPasswordController.clear();
                                      if (!mounted) return;
                                      customWidget.showCustomSnackBar(context, "Your Have Successfully Sign In!");
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          Routes.homeScreen,
                                          (Route<dynamic> route) => false);
                                    } else {
                                      if (!mounted) return;
                                      customWidget.showCustomWarningSnackBar(context,
                                          authProvider.errorResponse?.message);
                                    }
                                  } else {
                                    customWidget.showCustomWarningSnackBar(context, "Please fill all field");
                                  }
                                },
                                text: "Sign In",
                                backgroundColor: kThemeColor,
                                borderColor: Colors.transparent,
                              ),
                            );
                    }),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          isSecurePassword = !isSecurePassword;
        });
      },
      icon: isSecurePassword
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
      color: Colors.grey,
    );
  }
}
