enum Tripstate { active, empty, finished }
class Location {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  Location({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}
class CurrentItem {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final Location location;
  CurrentItem({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.location,
  });
}

class ActiveTrip {
  final String id;
  final String title;
  final String coverImage;
  final int currentDay;
  final int totalDay;
  ActiveTrip({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.currentDay,
    required this.totalDay,
  });
}

class GroupAlert {
  final bool hasAlert;
  final String message;

  GroupAlert({
    required this.hasAlert,
    required this.message,
  });
}

class NextItem {
  final String id;
  final String title;
  final String startTime;
  final String distance;
  final String imgUrl;
  NextItem({
    required this.id,
    required this.title,
    required this.startTime,
    required this.distance,
    required this.imgUrl,
  });
}

class HomeData {
  final Tripstate state;
  final ActiveTrip? activeTrip;
  final CurrentItem? currentItem;
  final GroupAlert? groupAlert;
  final List<NextItem> nextItems;
  HomeData({
    required this.state,
    this.activeTrip,
    this.currentItem,
    this.groupAlert,
    this.nextItems = const [],
  });
}
