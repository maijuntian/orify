import 'package:gsy_github_app_flutter/common/model/m_user_entity.dart';
import 'package:gsy_github_app_flutter/common/model/region_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "RegionEntity") {
      return RegionEntity.fromJson(json) as T;
    } else if (T.toString() == "MUserEntity") {
      return MUserEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}