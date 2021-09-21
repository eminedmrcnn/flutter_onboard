import 'package:flutter/cupertino.dart';

import 'package:flutter_architecture/core/init/cache/locale_manager.dart';
import 'package:flutter_architecture/core/init/navigation/navigation_service.dart';

abstract class BaseViewModel {
  BuildContext? context;
  LocaleManager localeManager = LocaleManager.instance;
  NavigationService navigation = NavigationService.instance!;
  void setContext(BuildContext context);
  void init();
}
