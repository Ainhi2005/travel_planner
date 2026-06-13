import '../../domain/entities/home_entity.dart';

class LocationModel extends Location {
  LocationModel({
    required super.name,
    required super.address,
    required super.latitude,
    required super.longitude,
  });
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json["name"] ?? '',
      address: json["address"] ?? '',
      latitude: (json["latitude"] ?? 0.0).toDouble(),
      longitude: (json["longitude"] ?? 0.0).toDouble(),
    );
  }
}

class CurrentItemModel extends CurrentItem {
  CurrentItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.startTime,
    required super.endTime,
    required super.status,
    required super.location,
  });
  factory CurrentItemModel.fromJson(Map<String, dynamic> json) {
    // 1. Viết một cái hàm "ăn gian" nhỏ ở đây
    DateTime parseTime(String? timeStr) {
      if (timeStr == null || timeStr.isEmpty) return DateTime.now();
      try {
        // Ghép thêm ngày ảo vào trước để hàm parse không bị chửi
        return DateTime.parse("1970-01-01 $timeStr:00");
      } catch (e) {
        return DateTime.now();
      }
    }

    return CurrentItemModel(
      id: json["id"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      
      // 2. Thay vì dùng DateTime.parse trực tiếp thì xài hàm ăn gian ở trên
      startTime: parseTime(json["startTime"]),
      endTime: parseTime(json["endTime"]),
      
      status: json["status"] ?? '',
      location: LocationModel.fromJson(json["location"] ?? {}),
    );
  }

}

class ActiveTripModel extends ActiveTrip {
  ActiveTripModel({
    required super.id,
    required super.title,
    required super.coverImage,
    required super.currentDay,
    required super.totalDay,
  });
  factory ActiveTripModel.fromJson(Map<String, dynamic> json) {
    return ActiveTripModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      coverImage: json['coverImage'] ?? '',
      currentDay: json['currentDay'] ?? 0.toInt(),
      totalDay: json['totalDay'] ?? 0.toInt(),
    );
  }
}

class GroupAlertModel extends GroupAlert {
  GroupAlertModel({required super.hasAlert, required super.message});
  factory GroupAlertModel.fromJson(Map<String, dynamic> json) {
    return GroupAlertModel(
      hasAlert: json['hasAlert'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class NextItemModel extends NextItem {
  NextItemModel({
    required super.id,
    required super.title,
    required super.startTime,
    required super.distance,
    required super.imgUrl,
  });
  factory NextItemModel.fromJson(Map<String, dynamic> json) {
    return NextItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      startTime: json['startTime'] ?? '',
      distance: "${json['distanceKm'] ?? 0} km",
      imgUrl: json['imageUrl'] ?? '',
    );
  }
}

class HomeModel extends HomeData {
  HomeModel({
    required super.state,
    super.activeTrip,
    super.currentItem,
    super.groupAlert,
    super.nextItems,
  });
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    Tripstate parsedState = Tripstate.empty;
    if (json['state'] == 'ongoing') parsedState = Tripstate.active;
    if (json['state'] == 'finished') parsedState = Tripstate.finished;
    return HomeModel(
      state: parsedState,
      activeTrip: json['activeTrip'] != null
          ? ActiveTripModel.fromJson(json['activeTrip'])
          : null,
      currentItem: json['currentItem'] != null
          ? CurrentItemModel.fromJson(json['currentItem'])
          : null,
      groupAlert: json['groupAlert'] != null
          ? GroupAlertModel.fromJson(json['groupAlert'])
          : null,
      nextItems: json['nextItems'] != null
          ? (json['nextItems'] as List)
                .map((i) => NextItemModel.fromJson(i))
                .toList()
          : [],
    );
  }
}
