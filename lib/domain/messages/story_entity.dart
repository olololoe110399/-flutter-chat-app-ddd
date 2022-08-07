import 'package:meta/meta.dart';

@immutable
class StoryEntity {
  const StoryEntity({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;
}
