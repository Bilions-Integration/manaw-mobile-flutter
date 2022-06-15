import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/styles.dart';

class CustomItemList extends StatefulWidget {
  final List items;

  final Map<String, dynamic> params;
  final Function() loadMore;
  final bool isLoading;
  final bool isLastPage;
  final Widget emptyWidget;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Function() refresh;
  const CustomItemList({
    Key? key,
    required this.items,
    required this.params,
    required this.loadMore,
    required this.isLoading,
    required this.isLastPage,
    required this.emptyWidget,
    required this.itemBuilder,
    required this.refresh,
  }) : super(key: key);

  @override
  State<CustomItemList> createState() => _CustomItemListState();
}

class _CustomItemListState extends State<CustomItemList> {
  ScrollController scrollController = ScrollController();
  bool isScrollLoading = false;
  bool isOnProgress = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: refreshListener,
      child: (widget.isLoading && widget.params['page'] == 1)
          ? Styles.loading
          : widget.items.isEmpty
              ? widget.emptyWidget
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  controller: scrollController,
                  itemCount: widget.items.length + 1,
                  itemBuilder: (context, index) {
                    if (index < widget.items.length) {
                      return widget.itemBuilder(context, index);
                    } else {
                      return Center(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: isScrollLoading
                                ? Styles.loading
                                : widget.isLastPage &&
                                        widget.params['page'] != 1
                                    ? const Text('End of results .',
                                        style: Styles.l5)
                                    : const SizedBox(height: 1)),
                      );
                    }
                  }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  Future<void> refreshListener() async {
    if (!isOnProgress) {
      setState(() {
        isOnProgress = true;
        widget.params['page'] = 1;
      });
      await widget.refresh();
      setState(() {
        isOnProgress = false;
      });
    }
  }

  void scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isOnProgress) {
        if (!widget.isLastPage) {
          setState(() {
            isScrollLoading = true;
            isOnProgress = true;
            widget.params['page'] += 1;
          });
          await widget.loadMore();
          setState(() {
            isScrollLoading = false;
            isOnProgress = false;
          });
        }
      }
    }
  }
}
