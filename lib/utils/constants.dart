part 'body_const.dart';
part 'firebase_consts.dart';

abstract class UserTypeConst {
  static const int simpleUser = 1;
  static const int admin = 2;
}


abstract class ForgotPassScreenConst {
  static const String email = "Email";
  static const String phone = "Phone number";
}

abstract class DashboardWidgetConst {
  static const int homeScreen = 0;
  static const int chatScreen = 1;
  static const int notificationScreen = 2;
  static const int profileScreen = 3;
}

abstract class DashboardSubWidgetConst {
  static const int mapScreen = 0;
  static const int idProofScreen = 1;
}

abstract class ChatTypeConst {
  static const int individual = 0;
  static const int groupChat = 1;
  static const int neighbourhood = 2;
}

abstract class SubscriptionTypeConst {
  static const int perMonth = 1;
  static const int yearly = 2;
}

abstract class SendNotificationTypeConst {
  static const int notSafe = 1;
  static const int safeNow = 2;
}

abstract class HomePageConst {
  static const String iFeelUnsafe = "I Feel Unsafe";
  static const String lifeThreateningDanger = "Life Threatening Danger";
  static const String iAmBeingKidnapped = "I'm Being Kidnapped";
  static const String policeInteraction = "Police Interaction";
  static const String callPolice = "Call Police";
}

abstract class AppLifecycleStateConst {
  static const String resumed="resumed";
  static const String inactive="inactive";
  static const String paused="paused";
  static const String detached="detached";

}

abstract class MapScreenConst {
  static const int currentLocation = 0;
  static const int sendSos = 1;
  static const int safeNow = 2;
}

abstract class AuthScreenConst {
  static const int signupScreen = 0;
  static const int forgotPassword = 1;
  static const int confirmLocationScreen = 2;
  static const int profileScreen = 3;
}
abstract class NotificationConst {
  static const String registrationIds="registration_ids";
  static const String notification="notification";
  static const String body="body";
  static const String type="type";
  static const String title="title";
  static const String androidChannelId="android_channel_id";
  static const String defaultNotificationChannelId="default_notification_channel_id";
  static const String sound="sound";

}
