enum AttachmentType { image, video, file }

class AttachmentTypeEnum {
  static List<AttachmentType> get list {
    return AttachmentType.values.toList();
  }

  static AttachmentType? getType(String? constantValue) {
    if (constantValue == null) {
      return null;
    }
    return AttachmentType.values
        .where((value) => value.constantValue == constantValue)
        .first;
  }

  //get type from mime
  static AttachmentType getTypeFromMime(String? mime) {
    if (mime == null) {
      return AttachmentType.file;
    }
    if (mime.contains('image')) {
      return AttachmentType.image;
    } else if (mime.contains('video')) {
      return AttachmentType.video;
    } else {
      return AttachmentType.file;
    }
  }
}

extension AttachmentTypeEnumExtension on AttachmentType {
  String get constantValue {
    switch (this) {
      case AttachmentType.image:
        return 'image';
      case AttachmentType.video:
        return 'video';
      case AttachmentType.file:
        return 'file';
    }
  }

  bool get isMedia =>
      this == AttachmentType.image || this == AttachmentType.video;
}
