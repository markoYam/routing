class BaseResponseModel {
  final int status;
  final String message;
  //final List<Datum> data;

  BaseResponseModel({
    required this.status,
    required this.message,
    //required this.data,
  });

  BaseResponseModel copyWith({
    int? status,
    String? message,
    //List<Datum>? data,
  }) =>
      BaseResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        //data: data ?? this.data,
      );

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseResponseModel(
        status: json["status"],
        message: json["message"],
        //data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        // "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
