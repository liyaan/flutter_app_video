import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_video/config/AppConfig.dart';

class UserType {
  static Map enType = {
    'NORMAL_USER': 'NORMAL_USER',
    'DQ_SINGER': 'DQ_SINGER',
    'DQ_OFFICIAL_ACCOUNT': 'DQ_OFFICIAL_ACCOUNT',
    'ADMIN': 'ADMIN',
  };

  static Map cnType = {
    'NORMAL_USER': '普通用户',
    'DQ_SINGER': '读琴歌手',
    'DQ_OFFICIAL_ACCOUNT': '读琴号',
    'ADMIN': '管理员',
  };

  static Map colorType = {
    'NORMAL_USER': AppColors.unactive,
    'DQ_SINGER': AppColors.info,
    'DQ_OFFICIAL_ACCOUNT': AppColors.success,
    'ADMIN': AppColors.danger,
  };

  ///转英文
  static String formEn(String type) {
    return enType[type];
  }

  ///转中文
  static String formCn(String type) {
    return cnType[type] ?? "未知用户";
  }

  ///转颜色
  static Color formColor(String type) {
    return colorType[type] ?? AppColors.unactive;
  }

  static bool isNormal(String type) => type == enType['NORMAL_USER'];
  static bool isSinger(String type) => type == enType['DQ_SINGER'];
  static bool isOfficial(String type) => type == enType['DQ_OFFICIAL_ACCOUNT'];
  static bool isAdmin(String type) => type == enType['ADMIN'];
}

/// 随机获取指定返回内的数值
///
/// from [min] 含，to [max] 含
int getRandomRangeInt(int min, int max) {
  final Random random = new Random();
  return min + random.nextInt(max + 1 - min);
}

String secondsToTime(int seconds) {
  if (seconds == null || seconds <= 0 || seconds.isNaN) {
    return '00:00';
  }
  // 时分数
  int hours = 0;
  // 分钟数
  int minutes = 0;
  // 除整数分钟外剩余的秒数
  int remainingSeconds = 0;

  hours = (seconds / 60 / 60).floor();
  minutes = (seconds / 60 % 60).floor();
  remainingSeconds = seconds % 60;

  return '${formatNumber(hours)}:${formatNumber(minutes)}:${formatNumber(remainingSeconds)}';
}

String formatNumber(int count) {
  String strCount = count.toString();
  return strCount.length > 1 ? strCount : '0$strCount';
}
