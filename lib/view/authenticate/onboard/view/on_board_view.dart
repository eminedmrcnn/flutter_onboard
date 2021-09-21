import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_architecture/view/deneme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/base/widget/base_widget.dart';
import '../../../../core/extension/context_extension.dart';
import '../model/on_board_model.dart';
import '../viewModel/on_board_view_model.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardViewModel>(
      viewModel: OnBoardViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, OnBoardViewModel viewModel) =>
          Scaffold(
        body: Padding(
          padding: context.paddingNormalHorizontal,
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 5,
                child: buildPageView(viewModel),
              ),
              Expanded(
                flex: 2,
                child: buildRowFooter(viewModel, context),
              )
            ],
          ),
        ),
      ),
    );
  }

  PageView buildPageView(OnBoardViewModel viewModel) {
    return PageView.builder(
      itemCount: viewModel.onBoardItems.length,
      onPageChanged: (value) {
        viewModel.changeCurrentIndex(value);
      },
      itemBuilder: (context, index) =>
          buildColumnBody(context, viewModel.onBoardItems[index]),
    );
  }

  Row buildRowFooter(OnBoardViewModel viewModel, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: context.paddingLow,
                child: Observer(builder: (_) {
                  return CircleAvatar(
                    backgroundColor: Colors.amber
                        .withOpacity(viewModel.currentIndex == index ? 1 : 0.2),
                    radius: viewModel.currentIndex == index ? 8 : 5,
                  );
                }),
              );
            }),
      ),
      FloatingActionButton(
          backgroundColor: const Color(0xFF00BFA6),
          elevation: 0,
          child: const Icon(Icons.keyboard_arrow_right_outlined),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Deneme()));
          }),
    ]);
  }

  Column buildColumnBody(BuildContext context, OnBoardModel model) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: buildSvgPicture(model.imagePath),
        ),
        buildColumnDescription(context, model),
      ],
    );
  }

  Column buildColumnDescription(BuildContext context, OnBoardModel model) {
    return Column(
      children: [
        AutoSizeText(
          model.title,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        AutoSizeText(
          model.description,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  SvgPicture buildSvgPicture(
    String path,
  ) =>
      SvgPicture.asset(path);
}
