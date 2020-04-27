
class FehrisItemModel {
  String icon;
  String title;
  FehrisItemModel({this.icon, this.title});
  factory FehrisItemModel.fromJson(Map<String, dynamic> json) {
    return FehrisItemModel(title: json['title'] as String);
  }
}

