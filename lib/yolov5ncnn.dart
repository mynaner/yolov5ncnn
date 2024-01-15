/*
 * @Date: 2023-03-15 14:49:49
 * @LastEditors: dengxin 994386508@qq.com
 * @LastEditTime: 2024-01-15 11:17:40
 * @FilePath: /yolov5ncnn/lib/yolov5ncnn.dart
 */
import 'dart:convert';

import 'package:bitmap/bitmap.dart';
import 'package:flutter/services.dart';
import 'package:yolov5ncnn/YolovResult_modal.dart';

class Yolov5ncnn {
  final methodChannel = const MethodChannel('yolov5ncnn');

  Future<bool?> init() async {
    return await methodChannel.invokeMethod<bool>('init');
  }

  Future<List<YolovResult>> detect(Bitmap bitmap, bool useGpu) async {
    List<YolovResult> list = [];
    try {
      var res = await methodChannel.invokeMethod('detect', {
        "bitmap": bitmap.content,
        "use_gpu": useGpu,
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
