import 'dart:io';

import 'package:dating_app/app/data/enums/call_type.dart';
import 'package:flutter/foundation.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class FeatureFlagVideoResolution {
  /// Video resolution at 180p
  static const ldResolution = 180;

  /// Video resolution at 360p
  static const mdResolution = 360;

  /// Video resolution at 480p (SD)
  static const sdResolution = 480;

  /// Video resolution at 720p (HD)
  static const hdResolution = 720;
}

class JitsiConfig {
  static final featureFlags = {
    FeatureFlag.isAddPeopleEnabled: false,
    FeatureFlag.isAndroidScreensharingEnabled: false,
    FeatureFlag.isAudioFocusDisabled: false,
    FeatureFlag.isAudioMuteButtonEnabled: true,
    FeatureFlag.isAudioOnlyButtonEnabled: false,
    FeatureFlag.isCalendarEnabled: false,
    FeatureFlag.isCloseCaptionsEnabled: false,
    FeatureFlag.isConferenceTimerEnabled: false,
    FeatureFlag.isChatEnabled: false,
    FeatureFlag.isFilmstripEnabled: false,
    FeatureFlag.isFullscreenEnabled: true,
    FeatureFlag.isHelpButtonEnabled: false,
    FeatureFlag.isInviteEnabled: false,
    FeatureFlag.isIosRecordingEnabled: false,
    FeatureFlag.isIosScreensharingEnabled: false,
    FeatureFlag.isKickoutEnabled: false,
    FeatureFlag.isLiveStreamingEnabled: false,
    FeatureFlag.isLobbyModeEnabled: false,
    FeatureFlag.isMeetingNameEnabled: false,
    FeatureFlag.isMeetingPasswordEnabled: false,
    FeatureFlag.isNotificationsEnabled: true,
    FeatureFlag.isOverflowMenuEnabled: true,
    FeatureFlag.isPipEnabled: false,
    FeatureFlag.isRaiseHandEnabled: false,
    FeatureFlag.isReactionsEnabled: true,
    FeatureFlag.isRecordingEnabled: false,
    FeatureFlag.isReplaceParticipant: true,
    FeatureFlag.resolution: FeatureFlagVideoResolution.hdResolution,
    FeatureFlag.isSecurityOptionsEnabled: false,
    FeatureFlag.isServerUrlChangeEnabled: false,
    FeatureFlag.isTileViewEnabled: false,
    FeatureFlag.isToolboxAlwaysVisible: false,
    FeatureFlag.isToolboxEnabled: true,
    FeatureFlag.isVideoMuteButtonEnabled: true,
    FeatureFlag.isVideoShareButtonEnabled: false,
    FeatureFlag.isWelcomePageEnabled: false,
    FeatureFlag.isCallIntegrationEnabled:
        !kIsWeb && Platform.isAndroid ? false : true,
    FeatureFlag.isPrejoinPageEnabled: false,
  };

  static JitsiMeetingOptions createMeetingOptions(
      String roomName, callerName, userAvatarURL, CallType callType) {
    final options = JitsiMeetingOptions(
      roomNameOrUrl: roomName,
      userDisplayName: callerName,
      // userEmail: '',
      userAvatarUrl: userAvatarURL,
      isAudioOnly: callType == CallType.voice,
      isAudioMuted: false,
      isVideoMuted: false,
      featureFlags: JitsiConfig.featureFlags,
    );
    return options;
  }
}
