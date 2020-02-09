
import 'common/model/m_user_entity.dart';
import 'common/model/record_entity.dart';
import 'common/model/region_entity.dart';
import 'common/model/tracing_result_entity.dart';
import 'common/model/version_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "VersionEntity") {
      return VersionEntity.fromJson(json) as T;
    } else if (T.toString() == "RegionEntity") {
      return RegionEntity.fromJson(json) as T;
    } else if (T.toString() == "MUserEntity") {
      return MUserEntity.fromJson(json) as T;
    } else if (T.toString() == "RecordEntity") {
      return RecordEntity.fromJson(json) as T;
    } else if (T.toString() == "TracingResultEntity") {
      return TracingResultEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}