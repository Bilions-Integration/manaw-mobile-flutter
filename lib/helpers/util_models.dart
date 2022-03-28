class Options {
  final String name;
  final String icon;
  final String action;
  final String? type;
  Options(
      {required this.name,
      required this.icon,
      required this.action,
      this.type});
}

class PopupItem {
  final String name;
  final String icon;
  dynamic onTap;

  PopupItem({required this.name, required this.icon, this.onTap});
}