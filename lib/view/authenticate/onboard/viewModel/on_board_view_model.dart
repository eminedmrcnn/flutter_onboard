import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/constants/enums/preferences_keys_enum.dart';
import 'package:flutter_architecture/core/constants/navigation/navigation_constants.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../_product/_constants/image_path_svg.dart';
import '../model/on_board_model.dart';

part 'on_board_view_model.g.dart';

class OnBoardViewModel = _OnBoardViewModelBase with _$OnBoardViewModel;

abstract class _OnBoardViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  List<OnBoardModel> onBoardItems = [];

  @observable
  bool isLoading = true;

  @observable
  int currentIndex = 0;

  @action
  void changeCurrentIndex(int value) {
    currentIndex = value;
  }

  @override
  void init() {
    onBoardItems.add(
      OnBoardModel(
        LocaleKeys.onBoard_page1_title,
        LocaleKeys.onBoard_page1_description,
        SVGImagePaths.instance.foto1,
      ),
    );
    onBoardItems.add(
      OnBoardModel(
        LocaleKeys.onBoard_page2_title,
        LocaleKeys.onBoard_page2_description,
        SVGImagePaths.instance.foto2,
      ),
    );
    onBoardItems.add(
      OnBoardModel(
        LocaleKeys.onBoard_page3_title,
        LocaleKeys.onBoard_page3_description,
        SVGImagePaths.instance.foto3,
      ),
    );
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  Future<void> completeToBoard() async {
    changeLoading();
    await localeManager.setBoolValue(PreferencesKeys.IS_FIRST_APP, true);
    
    //changeLoading();

    navigation.navigatePage(path: NavigationConstants.denem);
  }
}
