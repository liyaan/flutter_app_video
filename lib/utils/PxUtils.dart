import 'package:flutter/cupertino.dart';

double toRpx(double size, BuildContext context) {
  double rpx = MediaQuery.of(context).size.width / 750;
  //  double rpx = Get.width / width;
  return size * rpx;
}

String formatCharCount(int count) {
  if (count == null || count <= 0 || count.isNaN) {
    return '0';
  }
  double doubleCount = count.toDouble();
  String prefix;
  if (count >= 10000) {
    if (count >= 100000000) {
      doubleCount = doubleCount / 100000000.0;
      prefix = doubleCount.toStringAsFixed(1) + "亿";
    } else if (count >= 10000000) {
      doubleCount = doubleCount / 1000000.0;
      prefix = doubleCount.toStringAsFixed(1) + "MM";
    } else {
      doubleCount = doubleCount / 10000.0;
      prefix = doubleCount.toStringAsFixed(1) + "W";
    }
  } else {
    prefix = count.toString();
  }
  return prefix;
}

/// 网络图默认图
String networkImageToDefault(String src) {
  return src ??
      'https://pic1.zhimg.com/80/v2-6afa72220d29f045c15217aa6b275808_720w.jpg?source=1940ef5c';
}
