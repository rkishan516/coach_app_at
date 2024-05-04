// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shikhsha_dhra_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShikshaDhraUserImpl _$$ShikshaDhraUserImplFromJson(
        Map<String, dynamic> json) =>
    _$ShikshaDhraUserImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      instituteId: json['instituteId'] as String?,
      role: $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$$ShikshaDhraUserImplToJson(
        _$ShikshaDhraUserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'instituteId': instance.instituteId,
      'role': _$RoleEnumMap[instance.role]!,
    };

const _$RoleEnumMap = {
  Role.student: 'student',
  Role.teacher: 'teacher',
  Role.headOfDepartment: 'headOfDepartment',
  Role.headOfInstitute: 'headOfInstitute',
};
