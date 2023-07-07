part of 'constants.dart';

abstract class FirebaseCollectionConst {
  static const String users = "users";
  static const String groupChat = "group_chat";
  static const String chats = "chats";
  static const String groups = "groups";
  static const String individual = "individual";
  static const String singleGroup = "single_group";
  static const String neighbourhood = "neighbourhood";
  static const String userBlockTable = "userBlockTable";
}

abstract class FirebaseOrderBy {
  static const String time = "time";
  static const String chatDateFormat = "yyyy-MM-dd HH:mm:ss";
}

abstract class UserBlockTableConst {
  static const String block = "block";
  static const String unBlock = "unBlock";
}

abstract class ChatMessageType {
  static const String text = "text";
  static const String image = "image";
  static const String video = "video";
  static const String link = "link";
  static const String location = "location";
}
