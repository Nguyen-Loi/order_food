import 'package:flutter/material.dart';
import 'package:project_order_food/locator.dart';
import 'package:project_order_food/ui/config/app_style.dart';
import 'package:project_order_food/ui/shared/app_color.dart';
import 'package:project_order_food/ui/shared/ui_helpers.dart';
import 'package:project_order_food/ui/view/common_view/loading_view/data_app.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => locator<DataApp>().initData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AText.listItem('TOMOTOZ'),
              UIHelper.verticalSpaceSmall(),
              CircularProgressIndicator(
                color: AColor.greenBold,
              ),
              const SizedBox(height: 4),
              AText.body('Đang tải....')
            ],
          ),
        ),
      ),
    );
  }
}
