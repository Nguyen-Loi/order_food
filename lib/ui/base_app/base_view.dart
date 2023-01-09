import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_order_food/core/extension/log.dart';
import 'package:project_order_food/ui/base_app/base_controller.dart';
import 'package:provider/provider.dart';

abstract class BaseView<T extends BaseController> extends StatelessWidget {
  const BaseView(T baseController, {super.key})
      : _baseController = baseController;

  final T _baseController;

  T get controller => _baseController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: _getWidget(),
      bottomSheet: bottomSheet(context),
      floatingActionButton: floatingActionButton(context),
      drawer: drawer,
    );
  }

  Widget? get drawer => null;

  Widget? bottomSheet(BuildContext context) => null;

  Widget? floatingActionButton(BuildContext context) => null;

  AppBar? appBar(BuildContext context) => null;

  Widget _getWidget() {
    return ChangeNotifierProvider<T>(
      create: (context) => _baseController,
      child: Consumer<T>(
        builder: ((context, controller, __) {
          var cacheData = controller.data;
          if (controller.loadData() != null && cacheData.isEmpty) {
            return _loadDataNormal(context);
          } else if (controller.loadDataStream() != null ) {
            return _loadDataStream(context);
          } else {
            return getMainView(context, controller);
          }
        }),
      ),
    );
  }

  ///Load data bình thường
  Widget _loadDataNormal(BuildContext context) {
    return FutureBuilder(
        future: controller.loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            logInfo('$this => Đang load data ');
            return getSkeletonView(context, controller);
          } else if (snapshot.hasError) {
            logError('$this => Có lỗi xãy ra ');
            return getWarningView('Có lỗi xãy ra => api không chính xác');
          } else {
           
            if (snapshot.data!.docs.isEmpty) {
              logError('$this => Không có dữ liệu ');
              return getEmtpyView();
            }
            controller.setData(snapshot.data);
            logSuccess('$this => Đã load data thành công');
            return getMainView(context, controller);
          }
        });
  }

  ///Load data stream
  ///Load data bình thường
  Widget _loadDataStream(BuildContext context) {
    return StreamBuilder(
        stream: controller.loadDataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            logInfo('$this => Đang load data ');
            return getSkeletonView(context, controller);
          } else if (snapshot.hasError) {
            logError('$this => Có lỗi xãy ra ');
            return getWarningView('Có lỗi xãy ra => api không chính xác');
          } else {
            QuerySnapshot<Object?>? data = snapshot.data;
             
            if (data!.docs.isEmpty) {
              logError('$this => Không có dữ liệu ');
              return getEmtpyView();
            }
            controller.setData(data);
            logSuccess('$this => Đã load data thành công');
            return getMainView(context, controller);
          }
        });
  }

  Widget getWarningView(String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(text),
        ),
      ],
    );
  }

  Widget getEmtpyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text('không có dữ liệu'),
        ),
      ],
    );
  }

  Widget getSkeletonView(BuildContext context, T controller) {
    return Material(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double heightItem = 150;
            final double height = constraints.maxHeight != double.infinity
                ? constraints.maxHeight
                : heightItem;
            final double width = constraints.maxWidth;
            if (heightItem > height) {
              heightItem = height;
            }
            final int count = height ~/ heightItem;
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: count,
              itemBuilder: (_, __) => SizedBox(
                height: heightItem,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getMainView(
    BuildContext context,
    T controller,
  );
}
