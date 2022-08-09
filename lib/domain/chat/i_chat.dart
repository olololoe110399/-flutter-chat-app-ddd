import 'dart:io';

import '../domain.dart';

abstract class IChat {
  Future<Result<List<String>>> uploadAttachments({
    required List<File> attachments,
  });
}
