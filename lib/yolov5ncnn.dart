import 'dart:convert';
import 'dart:math';

import 'package:bitmap/bitmap.dart';
import 'package:flutter/services.dart';
import 'package:yolov5ncnn/YolovResult_modal.dart';

class Yolov5ncnn {
  final methodChannel = const MethodChannel('yolov5ncnn');

   Future<bool?> init() async {
    print(" 开始初始化");
    return await methodChannel.invokeMethod<bool>('init');
  }

  Future<List<YolovResult>> detect(Bitmap bitmap, bool use_gpu) async {
    List<YolovResult> list = [];
    try {
      var res = await methodChannel.invokeMethod('detect', {
        "bitmap": bitmap.content,
        "use_gpu": use_gpu,
        "width": bitmap.width,
        "height": bitmap.height
      });
      var data = json.decode(res);

      if (data is List) {
        for (var element in data) {
          list.add(YolovResult.fromJson(element));
        }
      }
    } catch (e) {
      print(e);
    }
    return list;
  }
}
