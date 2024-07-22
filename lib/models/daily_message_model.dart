class DailyMessageModel {
  String? id;
  String? title;
  String? message;
  DateTime? date;
  bool? liked;
  String? backgroundImage;

  DailyMessageModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.liked,
    required this.backgroundImage,
  });

  factory DailyMessageModel.fromJson(Map<String, dynamic> json) {
    return DailyMessageModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      date: DateTime.parse(json['date']),
      liked: json['liked'],
      backgroundImage: json['backgroundImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'date': date?.toIso8601String(),
      'liked': liked,
      'backgroundImage': backgroundImage,
    };
  }

  DailyMessageModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? date,
    bool? liked,
    String? backgroundImage,
  }) {
    return DailyMessageModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      liked: liked ?? this.liked,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }
}
