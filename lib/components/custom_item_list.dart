import 'package:flutter/material.dart';
import 'package:my_app/helpers/styles.dart';

class CustomItemList extends StatefulWidget {
  const CustomItemList({
    Key? key, 
    required this.items, 
    required this.params,
    required this.loadMore, 
    required this.isLoading, 
    required this.isLastPage, 
    required this.emptyWidget, 
    required this.itemBuilder, 
  }) : super(key: key);

  final List items;
  final Map<String, dynamic> params;
  final Function() loadMore;
  final bool isLoading;
  final bool isLastPage;
  final Widget emptyWidget; 
  final Widget Function(BuildContext context,int index) itemBuilder; 

  @override
  State<CustomItemList> createState() => _CustomItemListState();
}

class _CustomItemListState extends State<CustomItemList> {
  ScrollController scrollController = ScrollController();
  bool isScrollLoading = false;

  void scrollListener() async {
    if(scrollController.offset >= scrollController.position.maxScrollExtent && !widget.isLastPage) {
      setState(() {
        isScrollLoading = true;
        widget.params['page'] += 1;
      });
      await widget.loadMore();
      setState(() {
        isScrollLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ( widget.isLoading && widget.params['page'] == 1 )
        ? Styles.loading
        : widget.items.isEmpty
        ? widget.emptyWidget 
        : ListView.builder(
          controller: scrollController,
          itemCount: widget.items.length + 1,
          itemBuilder: (context, index) {
            if(index < widget.items.length) {
              return widget.itemBuilder(context,index);
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child : isScrollLoading
                  ? Styles.loading
                  : widget.isLastPage && widget.params['page'] != 1
                  ? Text('End of results .', style: Styles.l5)
                  : const SizedBox(height: 0.5)
                ),
              );
            }
          }
        ),
    );
  }
}

