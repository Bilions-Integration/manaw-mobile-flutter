class DialogAction {
  final String name;
  final Function? handler;
  final String type;
  DialogAction({
    required this.name,
    this.handler,
    required this.type,
  });
}

class ManagePage {
  final String name;
  final dynamic page;
  ManagePage({
    required this.name,
    required this.page,
  });
}

class Options {
  final String name;
  final String icon;
  final String action;
  final String? type;
  Options({
    required this.name,
    required this.icon,
    required this.action,
    this.type,
  });
}

class PopupItem {
  final String name;
  final String icon;
  dynamic onTap;

  PopupItem({
    required this.name,
    required this.icon,
    this.onTap,
  });
}

class ProductMutationResult {
  final int? id;
  final String? type;
  ProductMutationResult({
    this.type,
    this.id,
  });
}
