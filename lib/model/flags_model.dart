class Flag {
  final String name;
  final String code;
  final String dialCode;

  Flag({
    required this.name,
    required this.code,
    required this.dialCode,
  });

  Flag.fromJson(Map json)
      : name = json['name'],
        code = json['code'],
        dialCode = json['dial_code'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'dial_code': dialCode,
      };
}

class FlagList {
  final List<Flag> flags;

  FlagList(this.flags);

  factory FlagList.fromJson(Map json) {
    return FlagList(
        (json['flags'] as List).map((e) => Flag.fromJson(e as Map)).toList());
  }

  Map<String, dynamic> toJson() {
    return {'flags': flags.map((Flag flag) => flag.toJson()).toList()};
  }
}
