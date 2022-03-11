import 'package:flutter/material.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/customer_model.dart';
import 'package:my_app/services/customer_service.dart';

class CustomerPicker {
  final double? height;
  final String? searchPlaceholder;
  final List<CustomerModel> menuList;
  final Function(CustomerModel) onSelect;
  final Function(String)? onSearch;

  CustomerPicker({
    required this.menuList,
    this.searchPlaceholder,
    this.onSearch,
    required this.onSelect,
    this.height = 1000,
  });

  void open() {
    BuildContext context = currentContext();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (builder) {
        return CustomerListView(
          height: height,
          context: context,
          onSelect: onSelect,
          searchPlaceholder: searchPlaceholder,
          menuList: menuList,
        );
      },
    );
  }
}

// List View Widget
class CustomerListView extends StatefulWidget {
  final BuildContext context;
  final double? height;
  final List<CustomerModel> menuList;
  final String? searchPlaceholder;
  final Function(CustomerModel) onSelect;
  const CustomerListView(
      {Key? key, required this.height, this.searchPlaceholder, required this.context, required this.menuList, required this.onSelect})
      : super(key: key);

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  List<CustomerModel> chosenList = [];

  @override
  void initState() {
    setState(() {
      chosenList = List.from(widget.menuList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          top: 7,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 6,
              width: 50,
              child: Container(
                decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            AppWidget.marginBottom(1),
            Padding(
              padding: const EdgeInsets.all(5),
              child: MyTextInput(
                placeholder: widget.searchPlaceholder ?? 'Search',
                icon: Icons.search,
                onChanged: _onSearch,
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: chosenList
                    .map(
                      (CustomerModel item) => Container(
                        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(4),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 20.0,
                          ),
                          dense: true,
                          onTap: () => {_selectModal(item, context)},
                          trailing: const Icon(
                            Icons.radio_button_checked,
                            size: 20,
                          ),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              borderRadiusCard(
                                3,
                                Image.network(
                                  item.image!,
                                  width: 30,
                                  height: 30,
                                ),
                                border: 2,
                              ),
                              mr(1),
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Email - ${item.email}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectModal(CustomerModel type, context) {
    Navigator.pop(context);
    widget.onSelect(type);
  }

  _onSearch(String keyword, String? column) async {
    List<CustomerModel> customers = await CustomerService.get(keyword: keyword);
    setState(() {
      chosenList = List.from(customers);
    });
  }
}
