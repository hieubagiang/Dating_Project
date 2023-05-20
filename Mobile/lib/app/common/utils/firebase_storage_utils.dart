class FirebaseStorageConstants {
  /// ===== COMMON =====
  static const String createAtField = 'create_at';
  static const String updateAtField = 'update_at';
  static const String expireAt = 'expire_at';
  static const String admin = 'admin';
  static const int limitRequest = 20;
  static const int limitBoostProfileInMinute = 15;
  // static const environmentCollection = 'environments';
  // static const environment = 'development';
  static const environment = 'development';

  /// Collection
  static const hobbiesCollection = 'hobbies';

  ///USER Collection
  static const usersCollection = 'users';
  static const locationField = 'location';
  static const feedFilterField = 'feed_filter';
  static const onlineField = 'online';
  static const nameField = 'name';
  static const genderField = 'gender';
  static const ageField = 'age';

  /// connection_screen
  static const interactionCollection = 'interaction';
  static const currentUserId = 'current_user_id';
  static const interactedType = 'interacted_type';
  static const interactedUserId = 'interacted_user_id';

  ///CHANNELS COLLECTION
  static const channelsCollection = 'channels';
  static const channelId = 'channel_id';
  static const membersField = 'members';
  static const memberIdsField = 'member_ids';
  static const messagesCollection = 'messages';
  static const callCollection = 'calls';

  static const boostCollection = 'boost';
  static const userId = 'user_id';
  static const idField = 'id';
  static const tokenField = 'token';

  ///COLLECTION
  static const subscriptionPackagesCollection = 'subscription_packages';
  static const paymentHistoriesCollection = 'payment_histories';
}
