import 'dart:io';
import 'package:bitmap/bitmap.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:yolov5ncnn/YolovResult_modal.dart';
import 'package:yolov5ncnn/yolov5ncnn.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<bool?> expansiveWork(Map<String, dynamic> arguments) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(
      arguments["rootIsolateToken"]);
  var res = await arguments["yolov5ncnn"].init();
  // port.send("res");
  //  print(arguments);
  return res;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ImagePicker _picker = ImagePicker();
  CameraController? controller;
  RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;

  Yolov5ncnn yolov5ncnn = Yolov5ncnn();
  bool isInt = false;
  List<YolovResult> datalist = [];
  File? newimage;
  int num = 0;
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
    if (photo == null) return;

    Bitmap bitmap = await Bitmap.fromProvider(FileImage(File(photo.path)));

    var data = await yolov5ncnn.detect(bitmap, false);

    setState(() {
      datalist = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          bottomNavigationBar: IconButton(
            icon: const Icon(Icons.add),
            color: isInt ? Colors.brown : Colors.amber,
            onPressed: onClick,
          ),
          body: ListView(
            children: [
              ElevatedButton(
                onPressed: initPlatformState,
                child: const Text("初始化"),
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
              ElevatedButton(onPressed: onCarams, child: const Text("拍照")),
              Text("$num"),
              Text(datalist.join())
            ],
          )),
    );
  }
}
