import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture/core/init/network/vexana_manager.dart';
import 'package:flutter_architecture/view/authenticate/login/model/login_model.dart';
import 'package:flutter_architecture/view/authenticate/login/service/ILoginService.dart';
import 'package:flutter_architecture/view/authenticate/login/service/login_service.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/model/base_view_model.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  ILoginService? loginService;

  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    loginService = LoginService(VexanaManager.instance.networkManager);
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

 @observable
  bool isLoading = false;

  @observable
  bool isLockOpen = false;

  @action
  Future<void> fetchLoginService() async {
    isLoadingChange();
    if (formState.currentState!.validate()) {
      final response = await loginService!.fetchUserControl(LoginModel(
          email: emailController!.text, password: passwordController!.text));

      if (response != null) {
        // ignore: deprecated_member_use
        scaffoldState.currentState!
            .showSnackBar(SnackBar(content: Text(response.token!)));
      }
    }
    isLoadingChange();
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }

  @action
  void isLockOverChange() {
    isLockOpen = !isLockOpen;
  }
}
