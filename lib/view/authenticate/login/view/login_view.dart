import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/base/widget/base_widget.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../_product/_constants/image_path_png.dart';
import '../viewModel/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, LoginViewModel value) =>
          DefaultTabController(
        length: 2,
        child: Scaffold(
          key: value.scaffoldState,
          backgroundColor: Colors.grey.shade200,
          body: SafeArea(
            child: Column(
              children: [
                buildAnimatedContainer(context),
                tabBarContainer(),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: context.paddingNormal,
                    child: buildForm(value, context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildAnimatedContainer(BuildContext context) {
    return AnimatedContainer(
        duration: context.lowDuration,
        // TODO BUNA BAK
        height:
            context.mediaQuery.viewInsets.bottom > 0 ? 0 : context.height * 0.3,
        color: Colors.white,
        child: Center(child: Image.asset(PNGImagePaths.instance.hotdogs)));
  }

  Container tabBarContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
      ),
      child: Padding(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 5),
        child: buildTabBar(),
      ),
    );
  }

  TabBar buildTabBar() {
    return TabBar(
      labelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Color(0xffffc93c),
      indicatorWeight: 4,
      tabs: [
        Tab(
          text: 'Login',
        ),
        Tab(
          text: 'SignUp',
        ),
      ],
    );
  }

  Form buildForm(LoginViewModel value, BuildContext context) {
    return Form(
      key: value.formState,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Spacer(
            flex: 6,
          ),
          buildTextFormFieldEmail(context, value),
          buildTextFormFieldPassword(context, value),
          Spacer(),
          buildTextForgot(),
          Spacer(
            flex: 6,
          ),
          loginButton(context, value),
          InkWell(
            onTap: () {},
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Don't have a account? "),
                  TextSpan(text: 'SignUp'),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget buildTextFormFieldPassword(
          BuildContext context, LoginViewModel viewModel) =>
      Observer(builder: (_) {
        return TextFormField(
          controller: viewModel.passwordController,
          validator: (value) =>
              value!.isNotEmpty ? null : 'this field required',
          obscureText: viewModel.isLockOpen,
          decoration: InputDecoration(
            labelText: 'PASSWORD',
            labelStyle: context.textTheme.subtitle1,
            focusColor: Colors.black12,
            icon: Icon(
              Icons.password,
              color: Color(0xffffc93c),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            suffixIcon: InkWell(
              onTap: () => viewModel.isLoadingChange(),
              child: Observer(builder: (_) {
                return Icon(
                  viewModel.isLockOpen ? Icons.lock : Icons.lock_open,
                );
              }),
            ),
          ),
        );
      });

  TextFormField buildTextFormFieldEmail(
      BuildContext context, LoginViewModel viewModel) {
    return TextFormField(
      controller: viewModel.emailController,
      validator: (value) => value!.isValidEmails ? null : 'asadsd',
      decoration: InputDecoration(
        labelText: 'EMAIL',
        labelStyle: context.textTheme.subtitle1,
        icon: Icon(
          Icons.email,
          color: Color(0xffffc93c),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget buildTextForgot() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Forgot Password',
      ),
    );
  }

  Widget loginButton(BuildContext context, LoginViewModel viewModel) {
    return Padding(
      padding: context.paddingNormal,
      child: Observer(builder: (_) {
        return ElevatedButton(
          onPressed: viewModel.isLoading ? null : () => viewModel.fetchLoginService(),
          child: Center(
              child: Text(
            'Login',
            style: context.textTheme.headline5,
          )),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Color(0xffffc93c),
            ),
          ),
        );
      }),
    );
  }
}
