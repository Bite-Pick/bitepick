import 'package:magambell/core/config/environment.dart';
import 'package:magambell/src/main.dart';

Future<void> main() async => Environment.newInstance(BuildType.prod).run();
