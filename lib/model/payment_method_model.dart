import 'package:my_app/helpers/helper.dart';

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
          List<String> res = [];
          var imgs = json['images'] as List?;
          if (imgs == null || imgs.isEmpty) {
            String img = json['image'];
            console.log("image  :", payload: img);
            res.add(img);
          } else {
            res.addAll((imgs.cast<String>()));
          }
          console.log("final : ", payload: res);
          return res;
        })(),
        label = json['label'],
        description = json['description'],
        channel = (json['channel'] as List).cast<String>(),
        selected = json['selected'];
}
/*

[
    {
        "key": "card",
        "images": [
            "https:\/\/api.manawstore.xyz\/image\/payment\/visa.png",
            "https:\/\/api.manawstore.xyz\/image\/payment\/master.png",
            "https:\/\/api.manawstore.xyz\/image\/payment\/jcb.png"
        ],
        "label": "Credit or debit card",
        "description": "Credit or debit card",
        "channel": [
            "CC"
        ],
        "selected": true
    },
    {
        "key": "kbz_pay",
        "label": "KBZPay",
        "images": [],
        "image": "https:\/\/api.manawstore.xyz\/image\/payment\/kbz.png",
        "description": "KBZPay QR",
        "channel": [
            "KBZQR"
        ],
        "selected": false
    },
    {
        "key": "cb_pay",
        "label": "CBPay",
        "image": "https:\/\/api.manawstore.xyz\/image\/payment\/cb.png",
        "description": "CBPay QR",
        "channel": [
            "CBPQR"
        ],
        "selected": false
    },
    {
        "key": "mpu",
        "label": "MPU",
        "image": "https:\/\/api.manawstore.xyz\/image\/payment\/mpu.png",
        "description": "Myanmar Payment Union",
        "channel": [
            "MPU"
        ],
        "selected": false
    },
    {
        "key": "all",
        "label": "All",
        "description": "All Payment Methods",
        "images": [
            "https:\/\/api.manawstore.xyz\/image\/payment\/visa.png",
            "https:\/\/api.manawstore.xyz\/image\/payment\/master.png",
            "https:\/\/api.manawstore.xyz\/image\/payment\/jcb.png",
            "https:\/\/api.manawstore.xyz\/image\/payment\/kbz.png",
            "https:\/\/api.manawstore.xyz\/image\/payment\/cb.png",
            "https:\/\/api.manawstore.xyz\/image\/payment\/mpu.png"
        ],
        "channel": [
            "ALL"
        ],
        "selected": false
    }
]

 */
