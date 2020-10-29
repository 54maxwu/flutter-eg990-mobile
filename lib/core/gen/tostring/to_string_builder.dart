import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'to_string_generator.dart';

Builder toString(BuilderOptions options) => SharedPartBuilder([
      ToStringGenerator(
        prettyPrint: options.config["prettyPrint"] ?? false,
        indent: options.config["indent"],
      )
    ], 'to_string');
