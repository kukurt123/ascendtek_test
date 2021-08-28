// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ImageModel _$$_ImageModelFromJson(Map<String, dynamic> json) =>
    _$_ImageModel(
      url: json['url'] as String? ?? '',
      stringTags: json['stringTags'] as List<dynamic>,
      views: json['views'] as int? ?? 0,
    );

Map<String, dynamic> _$$_ImageModelToJson(_$_ImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'stringTags': instance.stringTags,
      'views': instance.views,
    };
