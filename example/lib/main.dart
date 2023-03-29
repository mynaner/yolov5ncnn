import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:bitmap/bitmap.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:isolate_flutter/isolate_flutter.dart';
import 'package:yolov5ncnn/YolovResult_modal.dart';
import 'package:yolov5ncnn/yolov5ncnn.dart';

late List<CameraDescription> _cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp( MyApp());
}

@pragma('vm:entry-point')
Future<bool?> expansiveWork(Map<String,dynamic> arguments) async {
  print(arguments["rootIsolateToken"]);
  BackgroundIsolateBinaryMessenger.ensureInitialized(arguments["rootIsolateToken"]);
 var res =  await arguments["yolov5ncnn"].init();
 // port.send("res");
 //  print(arguments);
  return res;
}


class MyApp extends StatefulWidget {
   MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ImagePicker _picker = ImagePicker();
  CameraController? controller;
  RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;

  Yolov5ncnn yolov5ncnn =  Yolov5ncnn();
  bool isInt = false;
  List<YolovResult> datalist = [];
  File? newimage;
  int num=0;
  @override
  void initState() {
    super.initState();

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void initPlatformState() async {
    // var value = await compute(expansiveWork,{"yolov5ncnn":yolov5ncnn,"rootIsolateToken":rootIsolateToken});
    // print(value);
    yolov5ncnn.init();

    // sleep(Duration(seconds: 5));
    // print("===========休眠5秒后时间${DateTime.now()}===============");
    //
    // var port = ReceivePort();
    // port.listen((msg) {
    //   print("Received message from isolate $msg");
    // });
    // FlutterIsolate.spawn(expansiveWork, port.sendPort).then((value){
    //   print(value);
    // });


    // var isolate = await FlutterIsolate.spawn(spawnIsolate, port.sendPort);
    // print(isolate);
  }

  Future onClick() async {
    setState(() {
      num++;
    });
  }

  Future onCarams() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if(photo==null) return;


    var time =DateTime.now();

    Bitmap bitmap =await  Bitmap.fromProvider(FileImage(File(photo.path)));

   var data =  await yolov5ncnn.detect(bitmap,false);
   print(DateTime.now().microsecond -time.microsecond);
   print(data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          bottomNavigationBar:  IconButton(
            icon: Icon(Icons.add),
            color: isInt ? Colors.brown : Colors.amber,
            onPressed: onClick,
          ),
          body: ListView(
            children: [
              ElevatedButton(
                child: Text("初始化"),
                onPressed: initPlatformState,
              ),  
              Column(
                children: datalist
                    .map(
                      (e) => ListTile(
                        title: Text("${e.label}"),
                        leading: Text("${e.color}"),
                      ),
                    )
                    .toList(),
              ),
              ElevatedButton(onPressed: onCarams, child: Text("拍照")),
              Text("$num"),
            ],
          )),
    );
  }
}


