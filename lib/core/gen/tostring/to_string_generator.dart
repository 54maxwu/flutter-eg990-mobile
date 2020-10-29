import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'parser/code_generate.dart';
import 'parser/member_collect.dart';
import 'to_string.dart';

class ToStringGenerator extends GeneratorForAnnotation<ToString> {
  const ToStringGenerator({
    this.prettyPrint,
    this.indent,
  });

  final bool prettyPrint;
  final String indent;

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final clazz = element;

    if (!(element is ClassElement)) {
      print("Only supports class element");
      return null;
    }

    return generateToStringMethod(
        clazz,
        collectClassMemberToString(clazz),
        Config(
          prettyPrint: annotation.peek("prettyPrint")?.boolValue ?? prettyPrint,
          indent: annotation.peek("indent")?.stringValue ?? indent,
        ));
  }
}
