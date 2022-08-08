// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(error) => "Vui lòng kiểm tra cấu hình của bạn:\n ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "calls": MessageLookupByLibrary.simpleMessage("Gọi"),
        "connecting": MessageLookupByLibrary.simpleMessage("Đang kết nối"),
        "contacts": MessageLookupByLibrary.simpleMessage("Danh bạ"),
        "lastOnline":
            MessageLookupByLibrary.simpleMessage("Lần cuối trực tuyến:"),
        "members": MessageLookupByLibrary.simpleMessage("Thành viên:"),
        "messages": MessageLookupByLibrary.simpleMessage("Tin nhắn"),
        "noName": MessageLookupByLibrary.simpleMessage("Không có tên"),
        "notifications": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "offline": MessageLookupByLibrary.simpleMessage("Ngoại tuyến"),
        "ohNoSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Ôi không, đã xảy ra lỗi."),
        "online": MessageLookupByLibrary.simpleMessage("Trực tuyến"),
        "onlineNow": MessageLookupByLibrary.simpleMessage("Đang trực tuyến"),
        "pleaseCheckYourConfigError": m0,
        "profile": MessageLookupByLibrary.simpleMessage("Trang cá nhân"),
        "signOut": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "soEmptyngoAndMessageSomeone": MessageLookupByLibrary.simpleMessage(
            "Chưa có tin nào.\nHãy nhắn tin cho ai đó."),
        "stories": MessageLookupByLibrary.simpleMessage("Bảng tin"),
        "thereAreNotUsers":
            MessageLookupByLibrary.simpleMessage("Không có người dùng"),
        "typeSomething":
            MessageLookupByLibrary.simpleMessage("Gõ gì đó tại đây..."),
        "typingMessage": MessageLookupByLibrary.simpleMessage("Nhập tin nhắn"),
        "watchers": MessageLookupByLibrary.simpleMessage("Người theo dõi")
      };
}
