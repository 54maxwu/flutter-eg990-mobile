import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/agent_level.dart';

part 'agent_entity.freezed.dart';

@freezed
abstract class AgentEntity with _$AgentEntity {
  const factory AgentEntity({
    @Default('') String account,
    @Default(false) bool hasValidToken,
    @Default(AgentLevel.UNKNOWN) AgentLevel level,
  }) = _AgentEntity;
}
