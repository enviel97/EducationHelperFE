import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/ultils/funtions.dart';
import 'package:education_helper/helpers/ultils/validation.dart';
import 'package:education_helper/models/user.model.dart';
import 'package:education_helper/roots/bloc/app_bloc.dart';
import 'package:education_helper/views/auth/bloc/auth_bloc.dart';
import 'package:education_helper/views/auth/bloc/auth_state.dart';
import 'package:education_helper/views/widgets/clippart/notch_custom_clip.dart';
import 'package:education_helper/views/widgets/button/custom_text_button.dart';
import 'package:education_helper/views/widgets/custom_text_field.dart';
import 'package:education_helper/views/widgets/remove_scroll_grow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:education_helper/helpers/extensions/build_context_x.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  final double containerSize;
  final VoidCallback goLogin;

  const SignUpPage({
    required this.containerSize,
    required this.goLogin,
    Key? key,
  }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String password = '';
  String phoneNumber = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        final appBloc = BlocProvider.of<AppBloc>(context);
        if (state is AuthLoadingState) {
          appBloc.showLoading(context, 'Sign Up ...');
        }
        if (state is AuthErrorState) {
          appBloc.hiddenLoading(context);
          appBloc.showError(context, state.error);
        }
        if (state is AuthErrorsState) {
          appBloc.hiddenLoading(context);
          appBloc.showError(context, state.errors[0].values.first);
        }
        if (state is AuthSignupSuccessState) {
          appBloc.hiddenLoading(context);
          appBloc.showSuccess(context, 'Welcome');
          widget.goLogin();
        }
      },
      child: _mainUI(),
    );
  }

  Widget _mainUI() {
    final spacing = SPACING.M.vertical;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 25.0),
        width: double.infinity,
        height: widget.containerSize,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: NotchedCustomClippath(Offset(size.width - 95.0, 0.0)),
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  width: double.infinity,
                  height: widget.containerSize - 25.0,
                  decoration: BoxDecoration(
                    color:
                        isLightTheme ? kPrimaryColor : kSecondarySuperDarkColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageFromLocal.asPng('auth_welcome'),
                          width: size.width * .6,
                          fit: BoxFit.fitWidth,
                        ),
                        spacing,
                        Expanded(
                          child: RemoveScrollGrow(
                            scrollableView: SingleChildScrollView(
                              reverse: true,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    KTextField(
                                      iconData: Icons.email_rounded,
                                      hintText: 'Email',
                                      validation: isEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      onChange: (value) => email = value,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: KTextField(
                                            iconData:
                                                Icons.account_circle_rounded,
                                            hintText: 'Name',
                                            keyboardType: TextInputType.text,
                                            validation: isNotEmpty,
                                            onChange: (value) => name = value,
                                          ),
                                        ),
                                        SPACING.M.horizontal,
                                        Flexible(
                                          child: KTextField(
                                            iconData:
                                                Icons.phone_android_outlined,
                                            hintText: 'Phone',
                                            keyboardType: TextInputType.phone,
                                            validation: isPhone,
                                            onChange: (value) =>
                                                phoneNumber = value,
                                          ),
                                        ),
                                      ],
                                    ),
                                    KTextField(
                                      iconData: Icons.lock_rounded,
                                      hintText: 'Password',
                                      isSecurity: true,
                                      keyboardType: TextInputType.text,
                                      validation: isPassword,
                                      onChange: (value) => password = value,
                                    ),
                                    KTextField(
                                      iconData: Icons.lock_rounded,
                                      hintText: 'Password Confirm',
                                      isSecurity: true,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      validation: (value) =>
                                          isEqual(value, password),
                                      onChange: (value) =>
                                          confirmPassword = value,
                                      onSubmit: _submit,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        spacing,
                        KTextButton(
                          text: 'Sign Up',
                          onPressed: _signup,
                        ),
                        spacing,
                      ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(right: 70.0),
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: isLightTheme ? kSecondaryColor : kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.login_outlined),
                  color: kWhiteColor,
                  onPressed: widget.goLogin,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signup() async {
    context.disableKeyBoard();

    if (_formKey.currentState?.validate() ?? false) {
      await BlocProvider.of<AuthBloc>(context).signUp(User(
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber));
    }
  }

  void _submit(String value) {
    _signup();
  }
}
