package com.yolov5ncnn.yolov5ncnn;

import android.content.res.AssetManager;
import android.graphics.Bitmap;

public class PlateRecognition {
    private YoloV5Ncnn yolov5ncnn = new YoloV5Ncnn();
    public boolean init(AssetManager mgr){
        boolean yolo_code = yolov5ncnn.Init(mgr);
        return yolo_code;
    }



    public YoloV5Ncnn.Obj[] detect(Bitmap bitmap, boolean use_gpu){
        YoloV5Ncnn.Obj[] objects = yolov5ncnn.Detect(bitmap, use_gpu);
        return objects;
    }
    
} 




