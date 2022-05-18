class PaymentMethod {
  final String key;
  final List<String> images;
  final String label;
  final String description;
  final List<String> channel;
  bool selected;

  PaymentMethod.fromJson(Map json)
      : key = json['key'],
        images = (() {
          var imgs = json['images'] as List?;
          if (imgs == null || imgs.isEmpty) {
            return [json['image'] as String];
          } else {
            return imgs.cast<String>();
          }
        })(),
        label = json['label'],
        description = json['description'],
        channel = (json['channel'] as List).cast<String>(),
        selected = json['selected'];
}
