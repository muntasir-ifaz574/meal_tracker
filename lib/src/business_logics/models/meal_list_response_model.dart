class MealListResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  MealListResponseModel({this.success, this.message, this.data});

  MealListResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? type;
  String? name;
  String? calories;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.type,
        this.name,
        this.calories,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    name = json['name'];
    calories = json['calories'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['type'] = type;
    data['name'] = name;
    data['calories'] = calories;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
