import 'package:fl_structure/bussiness_logic/app_bloc_provider.dart';
import 'package:fl_structure/bussiness_logic/blocs/login_bloc/login_bloc.dart';
import 'package:fl_structure/bussiness_logic/blocs/toggle_blocs/auth_screen_toggle_blocs.dart';
import 'package:fl_structure/utils/all_getter.dart';
import 'package:fl_structure/utils/common.dart';
import 'package:fl_structure/utils/dialogs.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:fl_structure/utils/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // email.text = "singhgurpyar642@gmail.com";
    // pass.text = "123456";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await customDialog(
          context: context,
          onTapYes: () => exit(),
          content: exitMsg,
          title: "Exit",
        );
        return false;
      },
      child: AppBlocProvider(
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: screenHeight(context) * 0.40,
                    child: loginAndSignCommonScreen(context),
                  ),
                ],
              ),
              Positioned(
                top: screenHeight(context) * 0.35,
                bottom: 0,
                child: Container(
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: SingleChildScrollView(
                      child: BlocBuilder<ShowPasswordToggleBloc, bool>(
                        builder: (context, showPassword) {
                          return Form(
                            key: _formKey,
                            child: BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccess) {
                                  //pushTo(context, const DashBoard());

                                }
                                if (state is LoginFailed) {
                                  context
                                      .read<ShowPasswordToggleBloc>()
                                      .add(false);
                                  toast(
                                      msg:
                                      state.error.toTitleCase().toString());
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    yHeight(screenHeight(context) * 0.08),
                                    const Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                        color: primary,
                                      ),
                                    ),
                                    yHeight(
                                      20,
                                    ),
                                    TextFormField(
                                      cursorColor: primary,
                                      validator: emailValidator,
                                      controller: email,
                                      decoration: fieldDeco(
                                        borderSideColor: state is LoginFailed
                                            ? Colors.red
                                            : null,
                                        labelText: 'Email address',
                                        hintText: 'Enter your email',
                                      ),
                                    ),
                                    yHeight(
                                      10,
                                    ),
                                    TextFormField(
                                      cursorColor: primary,
                                      validator: passwordValidator,
                                      controller: pass,
                                      obscuringCharacter: "*",
                                      obscureText: (!showPassword),
                                      decoration: fieldDeco(
                                          borderSideColor: state is LoginFailed
                                              ? Colors.red
                                              : null,
                                          labelText: "Password",
                                          hintText: "Enter password",
                                          showSuffixIcon: true,
                                          suffix: SizedBox(
                                            child: IconButton(
                                              icon: Icon(
                                                showPassword
                                                    ? CupertinoIcons.eye
                                                    : CupertinoIcons.eye_slash,
                                                color: const Color(0xfff8a8a8a),
                                              ),
                                              onPressed: () {
                                                context
                                                    .read<
                                                    ShowPasswordToggleBloc>()
                                                    .add((!showPassword));
                                              },
                                            ),
                                          )),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {

                                          },
                                          child: const Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 18,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    yHeight(
                                      30,
                                    ),
                                    GeneralBtn(
                                      loading : state is LoginLoading,
                                      title: "Login",
                                      onTap: () async {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          context.read<LoginBloc>().add(
                                            GetLogin(
                                              email: email.text,
                                              password: pass.text,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Don't have an account?",
                                          style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 18,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {

                                          },
                                          child: const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              color: primary,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

/// 1. solve fcm token issue on login
/// 2. create ios build