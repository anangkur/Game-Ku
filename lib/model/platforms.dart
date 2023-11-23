import 'package:gameku/model/platform.dart';

class PlatformWrapper {
  Platform platform;

  PlatformWrapper.fromJsonMap(Map<String, dynamic> map)
      : platform = Platform.fromJsonMap(map["platform"]);
}
