class YolovResult {
  double? x;
  double? w;
  double? h;
  double? p1x;
  double? p1y;
  double? p2x;
  double? p2y;
  double? p3x;
  double? p3y;
  double? p4x;
  double? p4y;

  String? label;
  double? prob;
  String? color;

  YolovResult(this.p4x,
      {this.x,
      this.w,
      this.h,
      this.p1x,
      this.p1y,
      this.p2x,
      this.p2y,
      this.p3x,
      this.p3y,
      this.p4y,
      this.label,
      this.prob,
      this.color});

  YolovResult.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    w = json['w'];
    h = json['h'];
    p1x = json["p1x"];
    p1y = json["p1y"];
    p2x = json["p2x"];
    p2y = json["p2y"];
    p3x = json["p3x"];
    p3y = json["p3y"];
    p4x = json["p4x"];
    p4y = json["p4y"];

    label = json["label"];
    prob = json["prob"];
    color = json["color"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['x'] = x;
    data['w'] = w;
    data['h'] = h;
    data['p1x'] = p1x;
    data['p1y'] = p1y;
    data['p2x'] = p2x;
    data['p2y'] = p2y;
    data['p3x'] = p3x;
    data['p3y'] = p3y;
    data['p4x'] = p4x;
    data['p4y'] = p4y;

    data['label'] = label;
    data['prob'] = prob;
    data['color'] = color;
    return data;
  }
}
