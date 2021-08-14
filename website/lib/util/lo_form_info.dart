import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class LoFormInfo {
  static late final String name;
  static late final String version;
  static late final String repository;
  static late final String homepage;
  static late final String documentation;
  static late final String pub;
  static late final String author;

  /// Gets package info from LoForm's pubspec.yaml file
  static Future<void> load() async {
    const key = 'packages/lo_form/pubspec.yaml';
    final content = await rootBundle.loadString(key);
    final yaml = loadYaml(content) as YamlMap;

    name = yaml['name'] as String;
    version = yaml['version'] as String;
    repository = yaml['repository'] as String;
    homepage = yaml['homepage'] as String;
    documentation = yaml['documentation'] as String;
    pub = 'https://pub.dev/packages/$name';
    author = repository.replaceAll(name, '');
  }
}
