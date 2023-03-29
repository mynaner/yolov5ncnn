package com.yolov5ncnn.yolov5ncnn;


import android.app.Activity;
import android.os.Build;
import android.util.JsonWriter;
import android.util.Log;
import androidx.annotation.NonNull;

import java.nio.ByteBuffer;
import java.util.List;
import java.util.Map;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.graphics.Bitmap;

import android.view.View;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONStringer;

/** Yolov5ncnnPlugin */
public class Yolov5ncnnPlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private PlateRecognition yolov5ncnn = new PlateRecognition();


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "yolov5ncnn");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
   final Map<String, Object> arguments = call.arguments();
    switch (call.method){
      // 初始化
      case "init":
          boolean yolo_code = yolov5ncnn.init(activity.getAssets());
          result.success(yolo_code);
          break;
      //
      case "detect":
          byte[] byges = (byte[]) arguments.get("bitmap");
          int width = (int) arguments.get("width");
          int height = (int) arguments.get("height");
          boolean use_gpu = (boolean) arguments.get("use_gpu");
          Bitmap bitmap= Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);

          if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.CUPCAKE) {
              bitmap.copyPixelsFromBuffer(ByteBuffer.wrap(byges));
          }

          YoloV5Ncnn.Obj[] objects = yolov5ncnn.detect(bitmap, use_gpu);



          String res="";
          for (int i = 0; i <objects.length ; i++) {
              YoloV5Ncnn.Obj obj = objects[i];
             res = "{\"label\":" +
                     "\""+obj.label+"\"" +
                     ",\"color\":"+
                     "\""+obj.color+"\"" +
                     "}";
          }



          result.success("["+res+"]");
          break;
      default:
        result.notImplemented();
        break;
    }


  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }




    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.onDetachedFromActivity();

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this.onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }


}
