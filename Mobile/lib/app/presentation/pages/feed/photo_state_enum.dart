class PhotoStateEnum {
  static PhotoState? getType(int? id) {
    if (id == null) {
      return null;
    }
    return PhotoState.values.where((value) => value.id == id).first;
  }
}

enum PhotoState { none, like, dislike, recovery }

extension PhotoStateEnumExtension on PhotoState {
  int get id {
    switch (this) {
      case PhotoState.none:
        return 1;
      case PhotoState.like:
        return 2;
      case PhotoState.dislike:
        return 3;
      case PhotoState.recovery:
        return 4;
    }
  }
}
