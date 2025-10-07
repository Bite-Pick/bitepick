import 'package:magambell/src/core/config/environment.dart';

Future<void> main() async => Environment.newInstance(BuildType.dev).run();
