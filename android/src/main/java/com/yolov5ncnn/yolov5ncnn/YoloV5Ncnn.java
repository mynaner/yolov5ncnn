package com.yolov5ncnn.yolov5ncnn;

import android.content.res.AssetManager;
import android.graphics.Bitmap;

public class YoloV5Ncnn {
    public native boolean Init(AssetManager mgr);

    public class Obj{
        public float x;
        public float y;
        public float w;
        public float h;

        public float p1x;
        public float p1y;
        public float p2x;
        public float p2y;
        public float p3x;
        public float p3y;
        public float p4x;
        public float p4y;
        public String label;
        public float prob;
        public String color;




        @Override
        public String toString() {
            return "Obj{" +
                    "x=" + x +
                    ", y=" + y +
                    ", w=" + w +
                    ", h=" + h +
                    ", p1x=" + p1x +
                    ", p1y=" + p1y +
                    ", p2x=" + p2x +
                    ", p2y=" + p2y +
                    ", p3x=" + p3x +
                    ", p3y=" + p3y +
                    ", p4x=" + p4x +
                    ", p4y=" + p4y +
                    ", label='" + label + '\'' +
                    ", prob=" + prob +
                    ", color='" + color + '\'' +
                    '}';
        }


        public float getX() {
            return x;
        }

        public void setX(float x) {
            this.x = x;
        }

        public float getY() {
            return y;
        }

        public void setY(float y) {
            this.y = y;
        }

        public float getW() {
            return w;
        }

        public void setW(float w) {
            this.w = w;
        }

        public float getH() {
            return h;
        }

        public void setH(float h) {
            this.h = h;
        }

        public float getP1x() {
            return p1x;
        }

        public void setP1x(float p1x) {
            this.p1x = p1x;
        }

        public float getP1y() {
            return p1y;
        }

        public void setP1y(float p1y) {
            this.p1y = p1y;
        }

        public float getP2x() {
            return p2x;
        }

        public void setP2x(float p2x) {
            this.p2x = p2x;
        }

        public float getP2y() {
            return p2y;
        }

        public void setP2y(float p2y) {
            this.p2y = p2y;
        }

        public float getP3x() {
            return p3x;
        }

        public void setP3x(float p3x) {
            this.p3x = p3x;
        }

        public float getP3y() {
            return p3y;
        }

        public void setP3y(float p3y) {
            this.p3y = p3y;
        }

        public float getP4x() {
            return p4x;
        }

        public void setP4x(float p4x) {
            this.p4x = p4x;
        }

        public float getP4y() {
            return p4y;
        }

        public void setP4y(float p4y) {
            this.p4y = p4y;
        }

        public String getLabel() {
            return label;
        }

        public void setLabel(String label) {
            this.label = label;
        }

        public float getProb() {
            return prob;
        }

        public void setProb(float prob) {
            this.prob = prob;
        }

        public String getColor() {
            return color;
        }

        public void setColor(String color) {
            this.color = color;
        }
    }

    public native Obj[] Detect(Bitmap bitmap, boolean use_gpu);


    static {
        System.loadLibrary("yolov5ncnn");
//        System.loadLibrary("opencv_demo");
    }
}
